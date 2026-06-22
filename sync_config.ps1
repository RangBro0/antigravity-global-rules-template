param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("Pull", "Push")]
    [string]$Mode
)

$LocalConfigDir = "$env:USERPROFILE\.gemini\config"
$RepoRoot = $PSScriptRoot
$RepoConfigDir = "$RepoRoot\config"
$ConnectorPath = "$env:USERPROFILE\.gemini\antigravity\scratch\mcp_plugin_connector.py"

# Utility: construct "내 드라이브" dynamically in Korean (Unicode) to prevent encoding corruption in PowerShell
$GDriveName = [string][char]0xb0b4 + " " + [string][char]0xb4dc + [string][char]0xb77c + [string][char]0xc774 + [string][char]0xbe0c

function Get-FileHashString($FilePath) {
    if (Test-Path $FilePath) {
        return (Get-FileHash $FilePath -Algorithm SHA256).Hash
    }
    return $null
}

if ($Mode -eq "Pull") {
    Write-Host ">>> Pull Mode: Applying template config to local PC."
    
    # 1. Check/Ask for GDrive share path
    # Try common drive letters (G:, H:, I:)
    $DetectedGDrivePath = $null
    foreach ($Drive in @("G", "H", "I")) {
        $TestPath = Join-Path "$($Drive):\" (Join-Path $GDriveName "antigravity_share\.gemini\antigravity\config")
        if (Test-Path $TestPath) {
            $DetectedGDrivePath = Join-Path "$($Drive):\" (Join-Path $GDriveName "antigravity_share")
            break
        }
    }
    
    if ($null -eq $DetectedGDrivePath) {
        Write-Host "Could not auto-detect Google Drive share path."
        $UserInputPath = Read-Host "Please enter the absolute path to your Google Drive share folder (e.g., G:\내 드라이브\antigravity_share)"
        if ([string]::IsNullOrWhiteSpace($UserInputPath)) {
            Write-Error "Google Drive share path is required to sync. Aborting."
            exit 1
        }
        $DetectedGDrivePath = $UserInputPath
    }
    
    $GDriveConfigDir = Join-Path $DetectedGDrivePath ".gemini\antigravity\config"
    Write-Host "Using Google Drive share path: $DetectedGDrivePath"
    
    # 2. Check/Ask for GitHub Personal Access Token (PAT)
    $GithubToken = $env:GITHUB_PERSONAL_ACCESS_TOKEN
    if ([string]::IsNullOrWhiteSpace($GithubToken)) {
        $GithubToken = $env:GITHUB_TOKEN
    }
    
    if ([string]::IsNullOrWhiteSpace($GithubToken)) {
        Write-Host "GitHub Personal Access Token (PAT) environment variable not found."
        $GithubToken = Read-Host "Please enter your GitHub Personal Access Token (ghp_...)"
        if ([string]::IsNullOrWhiteSpace($GithubToken)) {
            Write-Warning "No GitHub Token provided. GitHub MCP server may fail to run."
        }
    }
    
    # 3. Copy config and skills from repo
    if (Test-Path "$RepoConfigDir\skills") {
        robocopy "$RepoConfigDir\skills" "$LocalConfigDir\skills" /E /R:3 /W:5
    }
    if (Test-Path "$RepoConfigDir\plugins") {
        robocopy "$RepoConfigDir\plugins" "$LocalConfigDir\plugins" /E /R:3 /W:5
    }
    
    # 4. Apply and replace placeholders in mcp_config.json
    $RepoMcpJsonPath = "$RepoConfigDir\mcp_config.json"
    $LocalMcpJsonPath = "$LocalConfigDir\mcp_config.json"
    
    if (Test-Path $RepoMcpJsonPath) {
        $OldHash = Get-FileHashString $LocalMcpJsonPath
        
        $Content = Get-Content $RepoMcpJsonPath -Raw -Encoding utf8
        
        # Replace {{USERPROFILE}}
        $EscapedProfile = $env:USERPROFILE -replace '\\', '\\'
        $NewContent = $Content -replace '\{\{USERPROFILE\}\}', $EscapedProfile
        
        # Replace {{GITHUB_TOKEN}}
        $NewContent = $NewContent -replace '\{\{GITHUB_TOKEN\}\}', $GithubToken
        
        # Replace {{GD_SHARE_PATH}}
        $EscapedGDPath = $DetectedGDrivePath -replace '\\', '\\'
        $NewContent = $NewContent -replace '\{\{GD_SHARE_PATH\}\}', $EscapedGDPath
        
        New-Item -ItemType File -Force -Path $LocalMcpJsonPath | Out-Null
        [System.IO.File]::WriteAllText($LocalMcpJsonPath, $NewContent, [System.Text.Encoding]::UTF8)
        
        $NewHash = Get-FileHashString $LocalMcpJsonPath
        
        Write-Host "Local MCP config applied: $LocalMcpJsonPath"
        
        # 5. Cascading sync execution on hash change
        if ($OldHash -ne $NewHash) {
            Write-Host ">>> MCP Configuration Change Detected! Syncing local plugins..."
            if (Test-Path $ConnectorPath) {
                python $ConnectorPath sync
            } else {
                Write-Warning "Plugin connector script not found at: $ConnectorPath"
            }
        }
    }
    
    # 6. Mirror to Google Drive
    if (Test-Path $DetectedGDrivePath) {
        Write-Host ">>> Mirroring local settings to Google Drive share..."
        robocopy "$LocalConfigDir\skills" "$GDriveConfigDir\skills" /E /R:3 /W:5
        robocopy "$LocalConfigDir\plugins" "$GDriveConfigDir\plugins" /E /R:3 /W:5
        robocopy "$LocalConfigDir" "$GDriveConfigDir" "mcp_config.json" /R:3 /W:5
    }
}
elseif ($Mode -eq "Push") {
    Write-Host ">>> Push Mode: Copying local settings to repository and Google Drive."
    
    # We need to detect Google Drive path from local mcp_config.json
    $LocalMcpJsonPath = "$LocalConfigDir\mcp_config.json"
    $DetectedGDrivePath = $null
    
    if (Test-Path $LocalMcpJsonPath) {
        try {
            $Json = Get-Content $LocalMcpJsonPath -Raw -Encoding utf8 | ConvertFrom-Json
            $MemoryPath = $Json.mcpServers.memory.env.MEMORY_FILE_PATH
            if (![string]::IsNullOrWhiteSpace($MemoryPath)) {
                # Extract directory from file path (remove \memory.json and tail)
                $DetectedGDrivePath = Split-Path (Split-Path $MemoryPath -Parent) -Parent
            }
        } catch {}
    }
    
    if ($null -eq $DetectedGDrivePath) {
        # Fallback to common letters
        foreach ($Drive in @("G", "H", "I")) {
            $TestPath = Join-Path "$($Drive):\" (Join-Path $GDriveName "antigravity_share")
            if (Test-Path $TestPath) {
                $DetectedGDrivePath = $TestPath
                break
            }
        }
    }
    
    if ($null -eq $DetectedGDrivePath) {
        Write-Host "Could not auto-detect Google Drive share path for backup."
        $DetectedGDrivePath = Read-Host "Please enter the absolute path to your Google Drive share folder (e.g., G:\내 드라이브\antigravity_share)"
    }
    
    $GDriveConfigDir = Join-Path $DetectedGDrivePath ".gemini\antigravity\config"
    Write-Host "Using Google Drive share path: $DetectedGDrivePath"
    
    # 1. Copy local config/skills/plugins to repo
    robocopy "$LocalConfigDir\skills" "$RepoConfigDir\skills" /E /R:3 /W:5
    robocopy "$LocalConfigDir\plugins" "$RepoConfigDir\plugins" /E /R:3 /W:5
    
    # 2. Templatize and save mcp_config.json to repo
    $RepoMcpJsonPath = "$RepoConfigDir\mcp_config.json"
    
    if (Test-Path $LocalMcpJsonPath) {
        $Content = Get-Content $LocalMcpJsonPath -Raw -Encoding utf8
        
        # Replace user profile path
        $EscapedProfile = [Regex]::Escape($env:USERPROFILE)
        $NewContent = $Content -replace $EscapedProfile, '{{USERPROFILE}}'
        
        $EscapedProfileDouble = [Regex]::Escape(($env:USERPROFILE -replace '\\', '\\\\'))
        $NewContent = $NewContent -replace $EscapedProfileDouble, '{{USERPROFILE}}'
        
        # Replace Google Drive path with {{GD_SHARE_PATH}}
        if (![string]::IsNullOrWhiteSpace($DetectedGDrivePath)) {
            $EscapedGDPath = [Regex]::Escape($DetectedGDrivePath)
            $NewContent = $NewContent -replace $EscapedGDPath, '{{GD_SHARE_PATH}}'
            
            $EscapedGDPathDouble = [Regex]::Escape(($DetectedGDrivePath -replace '\\', '\\\\'))
            $NewContent = $NewContent -replace $EscapedGDPathDouble, '{{GD_SHARE_PATH}}'
        }
        
        # Replace GitHub Personal Access Token with {{GITHUB_TOKEN}}
        # Try to find Token in local config first
        $LocalToken = $null
        try {
            $Json = Get-Content $LocalMcpJsonPath -Raw -Encoding utf8 | ConvertFrom-Json
            $LocalToken = $Json.mcpServers.github.env.GITHUB_PERSONAL_ACCESS_TOKEN
        } catch {}
        
        if (![string]::IsNullOrWhiteSpace($LocalToken) -and ($LocalToken -notlike "{{*}}")) {
            $EscapedToken = [Regex]::Escape($LocalToken)
            $NewContent = $NewContent -replace $EscapedToken, '{{GITHUB_TOKEN}}'
        }
        
        New-Item -ItemType File -Force -Path $RepoMcpJsonPath | Out-Null
        [System.IO.File]::WriteAllText($RepoMcpJsonPath, $NewContent, [System.Text.Encoding]::UTF8)
        
        Write-Host "Repository config saved (templated): $RepoMcpJsonPath"
    }
    
    # 3. Sync to Google Drive share
    if (Test-Path $DetectedGDrivePath) {
        Write-Host ">>> Mirroring local settings to Google Drive share..."
        robocopy "$LocalConfigDir\skills" "$GDriveConfigDir\skills" /E /R:3 /W:5
        robocopy "$LocalConfigDir\plugins" "$GDriveConfigDir\plugins" /E /R:3 /W:5
        robocopy "$LocalConfigDir" "$GDriveConfigDir" "mcp_config.json" /R:3 /W:5
    }
}

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
    Write-Host ""
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host "   Antigravity Global Rules & Plugins Setup Wizard" -ForegroundColor Cyan
    Write-Host "==========================================================" -ForegroundColor Cyan
    
    # 1. Ask for installation mode (Auto vs Custom)
    Write-Host "Choose installation type:"
    Write-Host "  [1] Auto (Default) - Install all rules, skills, and plugins automatically."
    Write-Host "  [2] Custom - Selectively choose which skills/plugins to install."
    $InstallType = Read-Host "Select option [1 or 2, Default: 1]"
    $IsCustomMode = ($InstallType -eq "2")

    $InstallList = @{
        "mcp_manager"        = $true
        "workflow_creator"   = $true
        "token_conservation" = $true
        "global_rules"       = $true
        "github"             = $true
        "sqlite"             = $true
        "memory"             = $true
        "playwright"         = $true
        "defaults"           = $true
    }

    if ($IsCustomMode) {
        Write-Host ""
        Write-Host "--- Custom Selection Mode ---" -ForegroundColor Yellow
        Write-Host "Please answer y (yes) or n (no) for each item."

        # Global Skills
        Write-Host ""
        Write-Host "[Skill] SKILL_A_plugin_mcp_manager" -ForegroundColor Green
        Write-Host "  - Purpose: Manages MCP server configuration and plug-in compiling."
        Write-Host "  - Requirement: None"
        $Ans = Read-Host "  Install this skill? (y/n) [Default: y]"
        if ($Ans -eq "n") { $InstallList["mcp_manager"] = $false }

        Write-Host ""
        Write-Host "[Skill] SKILL_C_workflow_skill_creator" -ForegroundColor Green
        Write-Host "  - Purpose: Automatically distill solved tasks/bugs into reusable skills."
        Write-Host "  - Requirement: None"
        $Ans = Read-Host "  Install this skill? (y/n) [Default: y]"
        if ($Ans -eq "n") { $InstallList["workflow_creator"] = $false }

        Write-Host ""
        Write-Host "[Skill] token_conservation" -ForegroundColor Green
        Write-Host "  - Purpose: Minimizes token usage and API costs via code slicing."
        Write-Host "  - Requirement: None"
        $Ans = Read-Host "  Install this skill? (y/n) [Default: y]"
        if ($Ans -eq "n") { $InstallList["token_conservation"] = $false }

        # Global Rules Plugin
        Write-Host ""
        Write-Host "[Plugin] custom-global-rules (Contains 6 core rules)" -ForegroundColor Green
        Write-Host "  - Purpose: Enforces code quality, security checks, and Korean output guidelines."
        Write-Host "  - Requirement: None"
        $Ans = Read-Host "  Install this global rules plugin? (y/n) [Default: y]"
        if ($Ans -eq "n") { $InstallList["global_rules"] = $false }

        # MCP Plugins
        Write-Host ""
        Write-Host "[MCP Plugin] github-plugin" -ForegroundColor Green
        Write-Host "  - Purpose: Auto-manage repositories, issues, commits, and PRs."
        Write-Host "  - Requirement: GitHub Account & Personal Access Token (PAT)"
        $Ans = Read-Host "  Install this GitHub plugin? (y/n) [Default: y]"
        if ($Ans -eq "n") { $InstallList["github"] = $false }

        Write-Host ""
        Write-Host "[MCP Plugin] sqlite-plugin" -ForegroundColor Green
        Write-Host "  - Purpose: Query SQLite databases and check schema validity."
        Write-Host "  - Requirement: Google Drive app OR Local Data Directory"
        $Ans = Read-Host "  Install this SQLite plugin? (y/n) [Default: y]"
        if ($Ans -eq "n") { $InstallList["sqlite"] = $false }

        Write-Host ""
        Write-Host "[MCP Plugin] memory-plugin" -ForegroundColor Green
        Write-Host "  - Purpose: Manages structured long-term memory via Knowledge Graphs."
        Write-Host "  - Requirement: Google Drive app OR Local Data Directory"
        $Ans = Read-Host "  Install this Memory plugin? (y/n) [Default: y]"
        if ($Ans -eq "n") { $InstallList["memory"] = $false }

        Write-Host ""
        Write-Host "[MCP Plugin] playwright-plugin" -ForegroundColor Green
        Write-Host "  - Purpose: Runs background headless browsers for visual page analysis."
        Write-Host "  - Requirement: Local Playwright browser installation"
        Write-Host "  - WARNING: High token consumption risk." -ForegroundColor Red
        $Ans = Read-Host "  Install this Playwright plugin? (y/n) [Default: y]"
        if ($Ans -eq "n") { $InstallList["playwright"] = $false }

        # Default system plugins
        Write-Host ""
        Write-Host "[System Plugins] Default Bundle (Firebase, Chrome Devtools, SDK, etc.)" -ForegroundColor Green
        Write-Host "  - Purpose: Essential plugins packaged for Antigravity integration."
        $Ans = Read-Host "  Install default plugins? (y/n) [Default: y]"
        if ($Ans -eq "n") { $InstallList["defaults"] = $false }
    }

    # 2. Check/Ask for GDrive share path
    $DetectedGDrivePath = $null
    $GDriveEnabled = $false

    # Only ask for GDrive if SQLite or Memory is chosen
    if ($InstallList["sqlite"] -or $InstallList["memory"]) {
        foreach ($Drive in @("G", "H", "I")) {
            $TestPath = Join-Path "$($Drive):\" (Join-Path $GDriveName "antigravity_share\.gemini\antigravity\config")
            if (Test-Path $TestPath) {
                $DetectedGDrivePath = Join-Path "$($Drive):\" (Join-Path $GDriveName "antigravity_share")
                $GDriveEnabled = $true
                break
            }
        }
        
        if ($null -eq $DetectedGDrivePath) {
            Write-Host ""
            Write-Host "Could not auto-detect Google Drive share path."
            $UserInputPath = Read-Host "Please enter the absolute path to your Google Drive share folder (e.g., G:\내 드라이브\antigravity_share) [Press Enter to skip/use local storage]"
            if ([string]::IsNullOrWhiteSpace($UserInputPath)) {
                $LocalDataPath = Join-Path $LocalConfigDir "data"
                Write-Host "Google Drive sync skipped. Falling back to local data directory for database/memory files: $LocalDataPath"
                if (!(Test-Path $LocalDataPath)) {
                    New-Item -ItemType Directory -Force -Path $LocalDataPath | Out-Null
                }
                $DetectedGDrivePath = $LocalDataPath
                $GDriveEnabled = $false
            } else {
                $DetectedGDrivePath = $UserInputPath
                $GDriveEnabled = $true
            }
        }
    } else {
        # Fallback path if no GDrive MCP is selected
        $DetectedGDrivePath = Join-Path $LocalConfigDir "data"
    }
    
    $GDriveConfigDir = Join-Path $DetectedGDrivePath ".gemini\antigravity\config"
    
    # 3. Check/Ask for GitHub Personal Access Token (PAT)
    $GithubToken = ""
    if ($InstallList["github"]) {
        $GithubToken = $env:GITHUB_PERSONAL_ACCESS_TOKEN
        if ([string]::IsNullOrWhiteSpace($GithubToken)) {
            $GithubToken = $env:GITHUB_TOKEN
        }
        
        if ([string]::IsNullOrWhiteSpace($GithubToken)) {
            Write-Host ""
            Write-Host "GitHub Personal Access Token (PAT) environment variable not found."
            $GithubToken = Read-Host "Please enter your GitHub Personal Access Token (ghp_...) [Press Enter to skip]"
            if ([string]::IsNullOrWhiteSpace($GithubToken)) {
                Write-Warning "No GitHub Token provided. GitHub MCP server may fail to run."
                $GithubToken = ""
            }
        }
    }
    
    # 4. Copy selected config and skills from repo
    Write-Host ""
    Write-Host ">>> Copying files..." -ForegroundColor Cyan

    # Skills Copy
    if ($InstallList["mcp_manager"] -and (Test-Path "$RepoConfigDir\skills\SKILL_A_plugin_mcp_manager")) {
        robocopy "$RepoConfigDir\skills\SKILL_A_plugin_mcp_manager" "$LocalConfigDir\skills\SKILL_A_plugin_mcp_manager" /E /R:3 /W:5
    }
    if ($InstallList["workflow_creator"] -and (Test-Path "$RepoConfigDir\skills\SKILL_C_workflow_skill_creator")) {
        robocopy "$RepoConfigDir\skills\SKILL_C_workflow_skill_creator" "$LocalConfigDir\skills\SKILL_C_workflow_skill_creator" /E /R:3 /W:5
    }
    if ($InstallList["token_conservation"] -and (Test-Path "$RepoConfigDir\skills\token_conservation")) {
        robocopy "$RepoConfigDir\skills\token_conservation" "$LocalConfigDir\skills\token_conservation" /E /R:3 /W:5
    }

    # Plugins Copy
    if ($InstallList["global_rules"] -and (Test-Path "$RepoConfigDir\plugins\custom-global-rules")) {
        robocopy "$RepoConfigDir\plugins\custom-global-rules" "$LocalConfigDir\plugins\custom-global-rules" /E /R:3 /W:5
    }
    if ($InstallList["github"] -and (Test-Path "$RepoConfigDir\plugins\github-plugin")) {
        robocopy "$RepoConfigDir\plugins\github-plugin" "$LocalConfigDir\plugins\github-plugin" /E /R:3 /W:5
    }
    if ($InstallList["sqlite"] -and (Test-Path "$RepoConfigDir\plugins\sqlite-plugin")) {
        robocopy "$RepoConfigDir\plugins\sqlite-plugin" "$LocalConfigDir\plugins\sqlite-plugin" /E /R:3 /W:5
    }
    if ($InstallList["memory"] -and (Test-Path "$RepoConfigDir\plugins\memory-plugin")) {
        robocopy "$RepoConfigDir\plugins\memory-plugin" "$LocalConfigDir\plugins\memory-plugin" /E /R:3 /W:5
    }
    if ($InstallList["playwright"] -and (Test-Path "$RepoConfigDir\plugins\playwright-plugin")) {
        robocopy "$RepoConfigDir\plugins\playwright-plugin" "$LocalConfigDir\plugins\playwright-plugin" /E /R:3 /W:5
    }

    # Defaults Copy
    if ($InstallList["defaults"]) {
        foreach ($Plug in @("chrome-devtools-plugin", "firebase", "google-antigravity-sdk", "modern-web-guidance-plugin")) {
            if (Test-Path "$RepoConfigDir\plugins\$Plug") {
                robocopy "$RepoConfigDir\plugins\$Plug" "$LocalConfigDir\plugins\$Plug" /E /R:3 /W:5
            }
        }
    }
    
    # 5. Apply and replace placeholders in mcp_config.json (Filtered by selection)
    $RepoMcpJsonPath = "$RepoConfigDir\mcp_config.json"
    $LocalMcpJsonPath = "$LocalConfigDir\mcp_config.json"
    
    if (Test-Path $RepoMcpJsonPath) {
        $OldHash = Get-FileHashString $LocalMcpJsonPath
        
        $Content = Get-Content $RepoMcpJsonPath -Raw -Encoding utf8
        $JsonObj = ConvertFrom-Json $Content

        # Dynamically remove deselected MCP servers from mcp_config.json
        if (-not $InstallList["github"]) {
            $JsonObj.mcpServers.PSObject.Properties.Remove("github")
        }
        if (-not $InstallList["memory"]) {
            $JsonObj.mcpServers.PSObject.Properties.Remove("memory")
        }
        if (-not $InstallList["sqlite"]) {
            $JsonObj.mcpServers.PSObject.Properties.Remove("sqlite")
        }
        if (-not $InstallList["playwright"]) {
            $JsonObj.mcpServers.PSObject.Properties.Remove("playwright")
        }

        # Convert back to JSON string for placeholder replacement
        $FilteredContent = ConvertTo-Json $JsonObj -Depth 100
        
        # Replace {{USERPROFILE}}
        $EscapedProfile = $env:USERPROFILE -replace '\\', '\\'
        $NewContent = $FilteredContent -replace '\{\{USERPROFILE\}\}', $EscapedProfile
        
        # Replace {{GITHUB_TOKEN}}
        $NewContent = $NewContent -replace '\{\{GITHUB_TOKEN\}\}', $GithubToken
        
        # Replace {{GD_SHARE_PATH}}
        $EscapedGDPath = $DetectedGDrivePath -replace '\\', '\\'
        $NewContent = $NewContent -replace '\{\{GD_SHARE_PATH\}\}', $EscapedGDPath
        
        New-Item -ItemType File -Force -Path $LocalMcpJsonPath | Out-Null
        [System.IO.File]::WriteAllText($LocalMcpJsonPath, $NewContent, [System.Text.Encoding]::UTF8)
        
        $NewHash = Get-FileHashString $LocalMcpJsonPath
        
        Write-Host "Local MCP config applied: $LocalMcpJsonPath" -ForegroundColor Cyan
        
        # 6. Cascading sync execution on hash change (Only for installed servers)
        if ($OldHash -ne $NewHash) {
            Write-Host ">>> MCP Configuration Change Detected! Syncing local plugins..." -ForegroundColor Cyan
            if (Test-Path $ConnectorPath) {
                python $ConnectorPath sync
            } else {
                Write-Warning "Plugin connector script not found at: $ConnectorPath"
            }
        }
    }
    
    # 7. Mirror to Google Drive (only if requested by user)
    if ($GDriveEnabled -and (Test-Path $DetectedGDrivePath)) {
        Write-Host ""
        $MirrorAns = Read-Host "Do you want to mirror the applied settings back to Google Drive? (y/n) [Default: n]"
        if ($MirrorAns -match '^[yY]([eE][sS])?$') {
            Write-Host ">>> Mirroring local settings to Google Drive share..." -ForegroundColor Cyan
            robocopy "$LocalConfigDir\skills" "$GDriveConfigDir\skills" /E /R:3 /W:5
            robocopy "$LocalConfigDir\plugins" "$GDriveConfigDir\plugins" /E /R:3 /W:5
            robocopy "$LocalConfigDir" "$GDriveConfigDir" "mcp_config.json" /R:3 /W:5
        } else {
            Write-Host "Google Drive mirroring skipped."
        }
    } else {
        Write-Host "Google Drive mirroring skipped."
    }

    # 8. Optional: Ask to install Playwright browsers (Only if Playwright was selected)
    if ($InstallList["playwright"]) {
        $PlaywrightJsonPath = Join-Path $LocalConfigDir "plugins\playwright-plugin\plugin.json"
        if (Test-Path $PlaywrightJsonPath) {
            Write-Host ""
            Write-Host "Playwright MCP plugin detected."
            Write-Host "WARNING: Playwright browser automation is powerful but can cause extremely HIGH token usage (loading entire HTML pages)." -ForegroundColor Yellow
            $InstallPlaywright = Read-Host "Do you want to install Playwright browser binaries now? (y/n) [Default: n]"
            if ($InstallPlaywright -match '^[yY]([eE][sS])?$') {
                Write-Host "Installing Playwright browsers..." -ForegroundColor Cyan
                npx playwright install
            } else {
                Write-Host "Playwright browser installation skipped. (You can install later via 'npx playwright install')"
            }
        }
    }

    Write-Host ""
    Write-Host "Setup Completed Successfully!" -ForegroundColor Green
}
elseif ($Mode -eq "Push") {
    Write-Host ">>> Push Mode: Copying local settings to repository and Google Drive."
    
    $LocalMcpJsonPath = "$LocalConfigDir\mcp_config.json"
    $DetectedGDrivePath = $null
    
    if (Test-Path $LocalMcpJsonPath) {
        try {
            $Json = Get-Content $LocalMcpJsonPath -Raw -Encoding utf8 | ConvertFrom-Json
            $MemoryPath = $Json.mcpServers.memory.env.MEMORY_FILE_PATH
            if (![string]::IsNullOrWhiteSpace($MemoryPath)) {
                $DetectedGDrivePath = Split-Path (Split-Path $MemoryPath -Parent) -Parent
            }
        } catch {}
    }
    
    if ($null -eq $DetectedGDrivePath) {
        foreach ($Drive in @("G", "H", "I")) {
            $TestPath = Join-Path "$($Drive):\" (Join-Path $GDriveName "antigravity_share")
            if (Test-Path $TestPath) {
                $DetectedGDrivePath = $TestPath
                break
            }
        }
    }
    
    $GDriveEnabled = $true
    if ($null -eq $DetectedGDrivePath) {
        Write-Host "Could not auto-detect Google Drive share path for backup."
        $UserInputPath = Read-Host "Please enter the absolute path to your Google Drive share folder (e.g., G:\내 드라이브\antigravity_share) [Press Enter to skip Google Drive mirroring]"
        if ([string]::IsNullOrWhiteSpace($UserInputPath)) {
            Write-Host "Google Drive mirroring disabled."
            $GDriveEnabled = $false
        } else {
            $DetectedGDrivePath = $UserInputPath
        }
    }
    
    $GDriveConfigDir = Join-Path $DetectedGDrivePath ".gemini\antigravity\config"
    if ($GDriveEnabled) {
        Write-Host "Using Google Drive share path: $DetectedGDrivePath"
    }
    
    # 1. Copy local config/skills/plugins to repo (Only copy what exists locally)
    if (Test-Path "$LocalConfigDir\skills") {
        robocopy "$LocalConfigDir\skills" "$RepoConfigDir\skills" /E /R:3 /W:5
    }
    if (Test-Path "$LocalConfigDir\plugins") {
        robocopy "$LocalConfigDir\plugins" "$RepoConfigDir\plugins" /E /R:3 /W:5
    }
    
    # 2. Templatize and save mcp_config.json to repo
    $RepoMcpJsonPath = "$RepoConfigDir\mcp_config.json"
    
    if (Test-Path $LocalMcpJsonPath) {
        $Content = Get-Content $LocalMcpJsonPath -Raw -Encoding utf8
        
        $EscapedProfile = [Regex]::Escape($env:USERPROFILE)
        $NewContent = $Content -replace $EscapedProfile, '{{USERPROFILE}}'
        
        $EscapedProfileDouble = [Regex]::Escape(($env:USERPROFILE -replace '\\', '\\\\'))
        $NewContent = $NewContent -replace $EscapedProfileDouble, '{{USERPROFILE}}'
        
        if ($GDriveEnabled -and ![string]::IsNullOrWhiteSpace($DetectedGDrivePath)) {
            $EscapedGDPath = [Regex]::Escape($DetectedGDrivePath)
            $NewContent = $NewContent -replace $EscapedGDPath, '{{GD_SHARE_PATH}}'
            
            $EscapedGDPathDouble = [Regex]::Escape(($DetectedGDrivePath -replace '\\', '\\\\'))
            $NewContent = $NewContent -replace $EscapedGDPathDouble, '{{GD_SHARE_PATH}}'
        }
        
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
    
    # 3. Sync to Google Drive share (only if requested by user)
    if ($GDriveEnabled -and (Test-Path $DetectedGDrivePath)) {
        Write-Host ""
        $BackupAns = Read-Host "Do you want to backup/sync your local settings to Google Drive? (y/n) [Default: n]"
        if ($BackupAns -match '^[yY]([eE][sS])?$') {
            Write-Host ">>> Mirroring local settings to Google Drive share..."
            robocopy "$LocalConfigDir\skills" "$GDriveConfigDir\skills" /E /R:3 /W:5
            robocopy "$LocalConfigDir\plugins" "$GDriveConfigDir\plugins" /E /R:3 /W:5
            robocopy "$LocalConfigDir" "$GDriveConfigDir" "mcp_config.json" /R:3 /W:5
        } else {
            Write-Host "Google Drive backup skipped."
        }
    }
}

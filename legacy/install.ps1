# install.ps1
$userProfile = $env:USERPROFILE
$destPlugins = Join-Path $userProfile ".gemini\config\plugins\custom-global-rules"
$destWorkflowCreator = Join-Path $userProfile ".gemini\config\skills\SKILL_C_workflow_skill_creator"
$destMcpManager = Join-Path $userProfile ".gemini\config\skills\SKILL_A_plugin_mcp_manager"

Write-Host "Installing custom global rules and skills..." -ForegroundColor Cyan

# 1. 플러그인 복사
if (Test-Path $destPlugins) { 
    Remove-Item -Path $destPlugins -Recurse -Force 
}
$parentPlugins = Split-Path $destPlugins
if (-not (Test-Path $parentPlugins)) {
    New-Item -ItemType Directory -Force -Path $parentPlugins | Out-Null
}
Copy-Item -Path "plugins/custom-global-rules" -Destination $destPlugins -Recurse -Force
Write-Host "✓ Plugins installed to: $destPlugins" -ForegroundColor Green

# 2. 스킬 복사 (workflow-skill-creator)
if (Test-Path $destWorkflowCreator) { 
    Remove-Item -Path $destWorkflowCreator -Recurse -Force 
}
$parentWorkflow = Split-Path $destWorkflowCreator
if (-not (Test-Path $parentWorkflow)) {
    New-Item -ItemType Directory -Force -Path $parentWorkflow | Out-Null
}
Copy-Item -Path "skills/workflow-skill-creator" -Destination $destWorkflowCreator -Recurse -Force
Write-Host "✓ workflow-skill-creator installed to: $destWorkflowCreator" -ForegroundColor Green

# 3. 스킬 복사 (SKILL_A_plugin_mcp_manager)
if (Test-Path $destMcpManager) { 
    Remove-Item -Path $destMcpManager -Recurse -Force 
}
$parentMcp = Split-Path $destMcpManager
if (-not (Test-Path $parentMcp)) {
    New-Item -ItemType Directory -Force -Path $parentMcp | Out-Null
}
Copy-Item -Path "skills/SKILL_A_plugin_mcp_manager" -Destination $destMcpManager -Recurse -Force
Write-Host "✓ SKILL_A_plugin_mcp_manager installed to: $destMcpManager" -ForegroundColor Green

Write-Host "`nInstallation completed successfully! Please restart Antigravity Agent." -ForegroundColor Cyan

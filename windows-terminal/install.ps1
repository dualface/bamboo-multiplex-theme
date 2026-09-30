# Installs the Bamboo Multiplex color scheme as a Windows Terminal JSON fragment (current user).
# Run:  powershell -ExecutionPolicy Bypass -File .\install.ps1
$ErrorActionPreference = 'Stop'
$dest = Join-Path $env:LOCALAPPDATA 'Microsoft\Windows Terminal\Fragments\bamboo-multiplex'
New-Item -ItemType Directory -Force -Path $dest | Out-Null
Copy-Item -Force (Join-Path $PSScriptRoot 'bamboo-multiplex.json') (Join-Path $dest 'bamboo-multiplex.json')
Write-Host "Installed to $dest"
Write-Host 'Restart Windows Terminal, then pick "Bamboo Multiplex" under Settings > Profile > Appearance > Color scheme.'

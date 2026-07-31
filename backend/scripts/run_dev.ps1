# Run the Django + Channels dev server bound to the LAN so a physical device on
# the same Wi-Fi can reach the recitation WebSocket.
#
#   - HTTP/WS:  http(ws)://<this-machine-LAN-IP>:8000
#   - Android emulator reaches the host as 10.0.2.2 (set that in environments.dart).
#
# Usage (from the backend/ folder):  .\scripts\run_dev.ps1

$ErrorActionPreference = "Stop"
$backend = Split-Path -Parent $PSScriptRoot
Set-Location $backend

# Activate the local virtualenv if present.
$activate = Join-Path $backend "venv\Scripts\Activate.ps1"
if (Test-Path $activate) { & $activate }

# Show the LAN IPs so you know what to put in the Flutter dev environment.
Write-Host "LAN IPv4 addresses (use one of these as the dev host):" -ForegroundColor Cyan
Get-NetIPAddress -AddressFamily IPv4 |
    Where-Object { $_.IPAddress -notlike '127.*' -and $_.IPAddress -notlike '169.254.*' } |
    Select-Object IPAddress, InterfaceAlias | Format-Table -AutoSize

Write-Host "Starting on 0.0.0.0:8000 (ws://<LAN-IP>:8000/ws/recitation/)" -ForegroundColor Green
python manage.py runserver 0.0.0.0:8000

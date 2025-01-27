$response = Read-Host "Kill Q-Dir now? (y/N)"
if ($response -eq "Y" -or $response -eq "y") {
    Stop-Process -ProcessName "Q-Dir_x64" -Force
}

$response = Read-Host "Restart Explorer now? (y/N)"
if ($response -eq "Y" -or $response -eq "y") {
    Stop-Process -ProcessName "explorer" -Force
}

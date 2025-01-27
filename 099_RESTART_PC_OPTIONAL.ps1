# Confirmation message looks ugly!
# Restart-Computer -Confirm

$response = Read-Host "Restart PC? (Y/n)"
if ($response -eq "N" -or $response -eq "n") {
    Exit
}
Restart-Computer

# [Microsoft Edge WebView2 Runtime]
# Win10: can't uninstall from command line, use GUI method.
# Win11: can't uninstall from command line, can't uninstall with GUI method.

"Uninstalling [Microsoft Edge WebView2 Runtime]..."
$product = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like "*WebView2*" }
if ($product) {
    msiexec /x $product.IdentifyingNumber /quiet
}

Pause

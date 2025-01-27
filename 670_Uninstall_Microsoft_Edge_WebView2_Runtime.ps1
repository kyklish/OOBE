$product = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like "*WebView2*" }
msiexec /x $product.IdentifyingNumber /quiet
Pause

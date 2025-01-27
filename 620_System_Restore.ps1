"Run this script only from true 64bit application, for example: Explorer..."
"Enable System Restore on disk C:\ 4GB..."
Enable-ComputerRestore -Drive C:

# MaxSizeSpec must be 320MB or greater
# /MaxSize=4GB for absolute size
# /MaxSize=5% for percentual sizes
# /MaxSize=UNBOUNDED for unlimited size
vssadmin Resize ShadowStorage /For=C: /On=C: /MaxSize=4GB
Pause

# "System32" folder is fully accessible only from true 64bit apps!
# "Open a command prompt" shell extension from the 32bit Total Commander shell
#   will open the 32bit command shell!

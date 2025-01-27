@ECHO OFF

ECHO Disable 8dot3 name creation on all volumes...
fsutil 8dot3name set 1

ECHO Disable last access time updates
fsutil behavior set disableLastAccess 1

ECHO Check results...
fsutil 8dot3name query
fsutil behavior query disableLastAccess

:: REG Alternative
:: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem => NtfsDisable8dot3NameCreation (DWORD) => 1
:: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem => NtfsDisableLastAccessUpdate  (DWORD) => 1

PAUSE

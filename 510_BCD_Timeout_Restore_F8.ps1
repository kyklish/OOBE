"Restore legacy boot menu with F8 key..."
bcdedit /set "{default}" bootmenupolicy legacy
"Set boot timeout to 1 second..."
bcdedit /set "{bootmgr}" timeout 01
Pause

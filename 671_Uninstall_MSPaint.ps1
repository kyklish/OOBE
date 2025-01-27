"Windows Media Player and MS Paint does not allow set custom file associations."
"Windows Media Player removed in [Optional Features] script. MS Paint here."
# DISM /Online /Add-Capability /CapabilityName:Microsoft.Windows.MSPaint~~~~0.0.1.0 /NoRestart
DISM /Online /Remove-Capability /CapabilityName:Microsoft.Windows.MSPaint~~~~0.0.1.0 /NoRestart
Pause

"Enable Windows Optional Features..."
Enable-WindowsOptionalFeature -All -Online -FeatureName "DirectPlay"
Disable-WindowsOptionalFeature -Online -FeatureName "WindowsMediaPlayer"
Pause

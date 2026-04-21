"Enable Windows Optional Features..."
Enable-WindowsOptionalFeature -All -Online -FeatureName "DirectPlay"
Enable-WindowsOptionalFeature -All -Online -FeatureName "NetFx3"
Disable-WindowsOptionalFeature -Online -FeatureName "WindowsMediaPlayer"
Pause

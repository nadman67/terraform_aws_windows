<powershell>
New-Item -ItemType directory -Path C:\Packages
$WebClient = New-Object System.Net.WebClient
$WebClient.DownloadFile("https://cs44d51ae0a783fx471dx99d.blob.core.windows.net/healthsharedistros/HS-2017.2.1.801.3.18281-hscore15.032_hsaa15.032_hspi15.032_hsviewer15.032_linkage15.032-b8679-win_x64.exe","C:\Packages\healthshare.exe")
& C:\Packages\healthshare.exe /instance healthshare /qn INITIALSECURITY=Normal CACHEUSERPASSWORD=j2andUtoo

$WebClient.DownloadFile("https://notepad-plus-plus.org/repository/7.x/7.6/npp.7.6.Installer.exe","C:\Packages\npp.exe")
Start-Process -FilePath "C:\Packages\npp.exe" -ArgumentList '/S' -Verb runas -Wait

New-NetFirewallRule -DisplayName "HealthShare Web Management Portal" -Direction Inbound -Action Allow -Protocol TCP -LocalPort 57772
</powershell>
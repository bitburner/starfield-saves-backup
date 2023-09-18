# starfield-saves-backup
This Powershell script helps you easily backup Starfield Game Saves and Restore them.

__Edit the paths:__
replace %USERNAME% with your username:
```
$saveFolderPath = "C:\Users\%USERNAME%\Documents\My Games\Starfield\Saves"
```
Create a folder for your saves and put the path here:
```
$backupFolderPath = "C:\starfieldSavesBackup"
```
__Run the script:__
```
PS C:starfieldSavesBackup>.\StarfieldSavesBackup.ps1
```

If you get a security warning you can choose "[R] Run once"

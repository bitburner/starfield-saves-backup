$saveFolderPath = "C:\Users\%USERNAME%\Documents\My Games\Starfield\Saves"
$backupFolderPath = "C:\starfieldSavesBackup"

function Backup-Saves {
    $timestamp = Get-Date -Format "yyyyMMddHHmmss"
    $zipName = "Backup_$timestamp.zip"
    $zipPath = Join-Path -Path $backupFolderPath -ChildPath $zipName

    Compress-Archive -Path "$saveFolderPath\*" -DestinationPath $zipPath
    Remove-Item -Path "$saveFolderPath\*" -Recurse -Force
}

function Restore-Saves {
    $backups = Get-ChildItem -Path $backupFolderPath -Filter "*.zip"

    if ($backups.Count -eq 0) {
        Write-Host "No backups found!"
        return
    }

    $backups | ForEach-Object { Write-Host $_.Name }

    $selection = Read-Host "Enter the name of the backup to restore"
    $selectedBackup = Join-Path -Path $backupFolderPath -ChildPath $selection

    if (-not (Test-Path $selectedBackup)) {
        Write-Host "Invalid selection!"
        return
    }

    if ((Get-ChildItem -Path $saveFolderPath).Count -ne 0) {
        $choice = Read-Host "Save folder not empty! Backup current saves before restoring? (yes/no)"

        if ($choice -eq "yes") {
            Backup-Saves
        } else {
            Remove-Item -Path "$saveFolderPath\*" -Recurse -Force
        }
    }

    Expand-Archive -Path $selectedBackup -DestinationPath $saveFolderPath
}

$choice = Read-Host "Do you want to (1) Backup or (2) Restore?"

if ($choice -eq "1") {
    Backup-Saves
} elseif ($choice -eq "2") {
    Restore-Saves
} else {
    Write-Host "Invalid choice!"
}

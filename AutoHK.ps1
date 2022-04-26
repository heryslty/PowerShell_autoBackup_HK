$InputFolder= "E:\BACKUP_DB"
$OutputFolder="E:\BACKUP_DB"


# delete file .zip that have older more than 2 month
$DeletedMonth = (Get-Date).AddMonths(-2).ToString('yyyy_MM')
Remove-Item $OutputFolder\*$DeletedMonth* -Include '*.zip'

#Get files Backup full to process
$bakFiles = Get-ChildItem $InputFolder/* -Include '*.bak'


#loop through Backup full to zip
$bakFiles | ForEach-Object { 
    $zipSetName = "Backup_Full_" + $_.BaseName + ".zip"
    Compress-Archive -Path $_.FullName -DestinationPath "$OutputFolder\$zipSetName"
    Remove-Item -Path $_.FullName
}


#Get files Backup Trx to process
$trnFiles = Get-ChildItem $InputFolder/* -Include '*.trn'


#loop through all files to zip and delete original file
$trnFiles | ForEach-Object { 
    $zipSetName = "Backup_Trx_" + $_.BaseName + ".zip"
    Compress-Archive -Path $_.FullName -DestinationPath "$OutputFolder\$zipSetName"
    Remove-Item -Path $_.FullName
}


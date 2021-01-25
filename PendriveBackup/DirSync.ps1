$destinationDrives = Get-PSDrive -PSProvider 'FileSystem' | ?{Get-ChildItem -Path "$($_.Root)DirSyncDestinationDrive" -ErrorAction Ignore} | %{$_.Root}

if($destinationDrives.Count -ne 4)
{
    echo "Please insert the 4 backup drives, you muppet."
    exit 1
}

$sourceDrive = [System.IO.Path]::GetPathRoot("$PSScriptRoot")

$xmlContent = Get-Content -Path "$PSScriptRoot\DirSync.dsc"

if(-not $xmlContent) 
{
    echo "Couldn't find dirsync file. I'm confused."
    exit 1
}

[xml]$XmlDocument = $xmlContent

for($i=0; $i -lt 4; $i++)
{
    $XmlDocument.dirsyncpro.job[$i].src = $sourceDrive
    $XmlDocument.dirsyncpro.job[$i].dst = $destinationDrives[$i]
}

$XmlDocument.Save("$PSScriptRoot\DirSync.dsc")
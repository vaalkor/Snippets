#Select a file and a shortcut will be added to the startmenu folder. This is usefulfor pinning batch files to start.

[System.Reflection.Assembly]::LoadWithPartialName(“System.windows.forms”) | Out-Null

if(-not [System.IO.Directory]::Exists("C:\users\$env:username\shortcuts")){[System.IO.Directory]::CreateDirectory(("C:\users\$env:username\shortcuts")) }

$OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
$OpenFileDialog.initialDirectory = (pwd).Path
$OpenFileDialog.filter = “All files (*.*)| *.*”
$OpenFileDialog.ShowDialog() | Out-Null
$fileName = $OpenFileDialog.filename
$shortcutName = "C:\users\$env:username\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\$([System.IO.Path]::GetFileName($fileName)).lnk" 
$shortcutDirectory = [System.IO.Path]::GetDirectoryName($shortcutName)
$directory = [System.IO.Path]::GetDirectoryName($fileName)

if(-not $fileName){ exit 1 }

$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut($shortcutName)
$Shortcut.TargetPath = $fileName
$Shortcut.WorkingDirectory = $directoryto
$Shortcut.Save()

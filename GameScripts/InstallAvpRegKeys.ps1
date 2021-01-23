Set-Content -Path "C:\reee.txt" -Value "reee"
$regFileContent = Get-Content "$PSScriptRoot\AVP.reg"
$avpLocation = (ls $PSScriptRoot | ?{$_.Name -eq "Aliens vs. Predator 2 - Main Game"}).FullName.Replace('\', '\\')
$avpHuntLocation = (ls $PSScriptRoot | ?{$_.Name -eq "Aliens versus Predator 2 - Primal Hunt"}).FullName.Replace('\', '\\')
echo $avpLocation
echo $avpHuntLocation
$regFileContent = $regFileContent.Replace("<INSERT_AVP2_INSTALL_DIR>", $avpLocation).Replace("<INSERT_AVP2_PRIMALHUNT_INSTALL_DIR>", $avpHuntLocation)

Set-Content -Path "$PSScriptRoot\AVP_Temp.reg" -Value $regFileContent

&{reg import "$PSScriptRoot\AVP_Temp.reg" *>&1} | Out-NUll
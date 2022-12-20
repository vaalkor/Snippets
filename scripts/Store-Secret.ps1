param( 
    [Parameter(Mandatory=$true)][string]$VariableName
)

$cred = Get-Credential -Message "Enter the secret!" -UserName "-------"

Set-Variable -Name $VariableName -Value $cred.GetNetworkCredential().password

$cred = Get-Credential -Message "Enter the secret!" -UserName "-------"

$cred.GetNetworkCredential().password

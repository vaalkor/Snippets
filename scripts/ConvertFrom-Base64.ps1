param( 
    [Parameter(Mandatory=$true)][string]$Value 
)

[Text.Encoding]::Utf8.GetString([Convert]::FromBase64String($Value))
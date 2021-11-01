param( 
    [Parameter(Mandatory=$true)][string]$Value
)

[Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($Value))
# Just some snippets for dealing with the irritating PSCustomObject

# Iterate over note properties

$someVar | Get-Member -MemberType NoteProperty | Select-Object -Property Name

# Or you can just do... PSObject doesn't appear on tab autocomplete for some weird reason.

$someVar.PSObject.Properties
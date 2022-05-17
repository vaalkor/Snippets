param(
    [Parameter(Mandatory=$true)][string]$Name
)


git checkout HEAD -- $Name #Reset a single file.
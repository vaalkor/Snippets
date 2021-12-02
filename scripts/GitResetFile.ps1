param(
    [Parameter(Mandatory=$true)][string]$Path
)

git checkout HEAD -- $Path
param(
    [string]$Ref,
    [switch]$FromClip
)

if($FromClip)
{
    git log (Get-Clipboard).Trim() --oneline
    exit 0
}

if(-not $Ref)
{
    git log --oneline
}
else
{
    git log $Ref.Trim() --oneline
}
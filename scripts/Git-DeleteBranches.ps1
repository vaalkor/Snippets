param(
    [string]$Pattern,
    [switch]$Delete,
    [switch]$FromClip

)

if($FromClip)
{
    $Pattern = (Get-Clipboard).Trim()
}

if(-not $Pattern)
{
    "Need to provide a pattern to filter branches!"
    exit 666
}


if($Delete)
{
    git branch | sls $pattern | ?{$_} | %{git branch -D $_.Line.Trim().Replace('* ', '')}
}
else 
{
    git branch | sls $pattern | ?{$_} | %{$_.Line.Trim().Replace('* ', '')}
}

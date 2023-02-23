param(
    [Int]$Count = 5
)

$branches = git branch --sort=-committerdate | Select-Object -First $Count | %{$_.Replace('* ', '').Trim()}

$branches | %{ [PSCustomObject]@{
    Branch     = $_
    Commit = git log --format=%B -n 1 $_
} } | Format-Table -AutoSize



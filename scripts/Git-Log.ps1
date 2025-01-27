param(
    [string]$Ref,
    [switch]$FromClip,
    [int]$Count = 10
)

function Get-CommitMessage($ref){
    return (git show --format=%B -s $ref | Out-String).Trim()
}

function Print-GitLog($ref) {

    $commits = git log $ref --format='%h;%cn;%ar' -n $Count

    $commits | ForEach-Object {
        $hash, $committerName, $timeSinceString = $_ -split ';'
        $message = Get-CommitMessage $hash

        [PSCustomObject]@{
            Hash = $hash
            Committer = $committerName
            Time = $timeSinceString
            Message = $message
        }
    } | Format-Table -AutoSize
}

if($FromClip)
{
    Print-GitLog (Get-Clipboard).Trim()
    exit 0
}

if(-not $Ref)
{
    Print-GitLog (git branch --show-current | Out-String).Trim()
}
else
{
    Print-GitLog $Ref.Trim()
}

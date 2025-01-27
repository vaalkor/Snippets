param(
    [Int]$Count = 10000,
    [Switch]$Remote
)

function Format-TimeString {
    param(
        [Int]$Seconds
    )

    if ($Seconds -lt 60) {
        return "$Seconds seconds"
    } elseif ($Seconds -lt 3600) {
        $minutes = [math]::Round($Seconds / 60, 1)
        return "$minutes minutes"
    } elseif ($Seconds -lt 86400) {
        $hours = [math]::Round($Seconds / 3600, 1)
        return "$hours hours"
    } else {
        $days = [math]::Round($Seconds / 86400, 1)
        return "$days days"
    }
}

function Get-UnixTimestamp {
    return [int][double]::Parse((Get-Date -UFormat %s))
}

if($Remote){
    $branches = git branch -r --sort=-committerdate
}else{
    $branches = git branch --sort=-committerdate
}

$branches = $branches `
    | ForEach-Object{ $_.Replace('* ', '').Trim() } `
    | Where-Object { $_ -notmatch 'HEAD ->' }

$branches | ForEach-Object {
    $ref = $_
    $commit = (git log --format=%B -n 1 "$ref").Trim() | Select-Object -First 1
    $unixTimestamp, $timeSinceString, $author = (git show --format='%ct;%ar;%an' -s $ref | Out-String).Trim() -split ';'

    [PSCustomObject]@{
        Branch     = $ref
        Commit = $commit
        Author = $author
        UnixTimestamp = $unixTimestamp
        Time = $timeSinceString
} } `
    | Sort-Object -Property UnixTimestamp -Descending `
    | Select-Object -First $Count `
    | Format-Table -AutoSize -Property Branch, Author, Time, Commit

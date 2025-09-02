param(
    [Int]$Count = 10,
    [Switch]$Remote,
    [string]$Not = '',
    [switch]$All
)

if($All){
    $Count = 10000
}

if($Remote){
    $branches = git branch -r --sort=-committerdate
}else{
    $branches = git branch --sort=-committerdate
}

$branches = $branches `
    | ForEach-Object{ $_.Replace('* ', '').Trim() } `
    | Where-Object { $_ -notmatch 'HEAD ->' }

$branches `
    | Select-Object -First $Count `
    | ForEach-Object {
        $ref = $_
        $timeSinceString, $author, $commit = (git show --format='%ar;%an;%s' -s $ref | Out-String).Trim() -split ';', 3

        [PSCustomObject]@{
            Branch = $ref
            Commit = $commit
            Author = $author
            Time   = $timeSinceString
    } } `
    | Format-Table -AutoSize -Property Branch, Author, Time, Commit

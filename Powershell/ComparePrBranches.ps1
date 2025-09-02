[CmdletBinding()]
param(
  [Parameter(Mandatory=$true)][string]$source,
  [Parameter(Mandatory=$true)][string]$target
)

git fetch origin | Out-Null
$ticketNumbers = git log --oneline --left-right "origin/$source...origin/$target" |
    Where-Object { $_ -match '^\s*<' } |
    ForEach-Object {
        [regex]::Matches($_, '[A-Z]+-\d+') | ForEach-Object { $_.Value }
    }
$uniqueOrdered = [System.Collections.Generic.List[string]]::new()
foreach ($item in $ticketNumbers) {
    if (-not $uniqueOrdered.Contains($item)) {
        $uniqueOrdered.Add($item)
    }
}
$uniqueOrdered

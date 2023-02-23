param(
[Parameter(Mandatory=$true)][string]$BranchFilterRegex
)
git branch | ?{$_ -match $BranchFilterRegex} | Select -First 1 | %{git checkout $_.Trim()}
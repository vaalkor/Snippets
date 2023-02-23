$branch = (git branch | ?{$_.Trim().StartsWith("*")} | select -first 1 | %{$_.Substring(1).Trim()})
$branch | Set-Clipboard
$branch
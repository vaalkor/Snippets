git branch | ?{$_.Trim().StartsWith("*")} | select -first 1 | %{git push -u origin $_.Substring(1).Trim()}
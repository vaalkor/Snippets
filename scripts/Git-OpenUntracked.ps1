git status --porcelain | ?{$_.StartsWith("??")} | %{code ($_.Replace("??",""))}
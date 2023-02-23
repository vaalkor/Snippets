process{
    if(-not $_){return}
    elseif($_.GetType() -ne [string]){$_}
    else{
        $_.Split("`n")
    }
}

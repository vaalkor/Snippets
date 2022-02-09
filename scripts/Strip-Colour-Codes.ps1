begin{

}
process{2
    $_ | ForEach-Object { $_ -replace '\x1b\[[0-9;]*m','' }
}
end{

}
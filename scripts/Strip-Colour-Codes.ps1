begin{

}
process{
    $_ -replace '\x1b\[[0-9;]*m',''
}
end{

}
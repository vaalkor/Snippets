Param(
    [Parameter(Mandatory = $true)]
    [scriptblock]$ScriptBlock,

    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    $InputObject,
    [switch]$Descending
)

BEGIN {
    $counts = @{}
}

PROCESS {
    # $value = $ScriptBlock.Invoke($InputObject)
    # Why is this different?
    $value = & $ScriptBlock $InputObject | Out-String | ForEach-Object { $_.Trim() }
    # Write-Host "value: $value"
    if($counts.ContainsKey($value)){
        $counts[$value]++
    }else{
        $counts[$value] = 1
    }
}

END {
    if($Descending){
        $counts.Keys | Sort-Object {$counts[$_]} -Descending | ForEach-Object{"$($_): $($counts[$_])"}
    }else{
        $counts.Keys | Sort-Object {$counts[$_]} | ForEach-Object{"$($_): $($counts[$_])"}
    }
}

param(
    [Parameter(Mandatory=$true)][string[]]$People
)

$alphabet = @('C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z')

function Create-TopRow{
    $result = "WHAT`tTotal Cost`t"
    foreach($person in $People){
        $result += "$person portion`t$person paid`t"
    }
    $result += "NOTES"
    return $result
}

function Create-CostRow{
    return (@(1..(3+$People.Count*2)) | %{''}) -Join "`t"
}

function Create-TotalOwedSection{
    $result = "Person`t" + ($People -Join "`t") + "`n"
    $result += "Total Cost`t"
    for($i=0;$i -lt $People.Count;$i++){
        $offset = $i * 2
        $result += "=SUM($($alphabet[$offset])1:$($alphabet[$offset])10) - SUM($($alphabet[$offset+1])1:$($alphabet[$offset+1])10)`t"
    }
    return $result
}

Create-TopRow
@(1..9) | %{Create-CostRow}
Create-TotalOwedSection

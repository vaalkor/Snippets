# Opens a folder full of .eml files and counts up the senders.
param(
    [Parameter(Mandatory=$true)]
    $EmailFolder
)

if(-not (Test-Path $EmailFolder)){
    Write-Host "$EmailFolder does not exist"
    exit 1
}

$allSenders = @{}

foreach($file in Get-ChildItem -Path $EmailFolder -Filter *.eml){
    $senderName = Get-Content $file.FullName | Where-Object { $_.StartsWith("From: ") } | Select-Object -First 1
    $senderName = $senderName.Split('<')[1].Split('>')[0]
    $senderName
    $domain = $senderName.Split('@')[1]

    if($allSenders.ContainsKey($senderName)){
        $allSenders[$senderName]++
    }else{
        $allSenders[$senderName] = 1
    }

    if($domainSenders.ContainsKey($domain)){
        $domainSenders[$domain]++
    }else{
        $domainSenders[$domain] = 1
    }
}

"`n========= Results =========`n"
$allSenders.GetEnumerator() | Sort-Object -Property Value -Descending | Format-Table -AutoSize

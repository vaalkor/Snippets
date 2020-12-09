param([string]$transactionFile)

if(-not (Get-ChildItem $transactionFile))
{
    echo "Provide a transaction file you mug"
}

$transactionData = Import-Csv $transactionFile

$transactionTypes = @{
"ATM" = "Cash Machine Withdrawal"; 
"BP" = "BACS or Bill Payment (including Bill Payment credit)"; 
"CHQ" = "Cheque"; 
"CIR"= "Cirrus or Maestro card transaction, or Eurocheque transaction";
"CR" = "Credit (including BACS credit)";
"DD" = "Direct Debit";
"DIV" = "Dividend";
"DR" = "Debit";
"MAE" = "Maestro Debit Card Transaction";
"SO" = "Standing Order";
"TRF" = "Transfer";
"VIS" = "Visa debit card payment";
")))" = "Contactless debt card payment"}

foreach($type in $transactionTypes.Keys)
{
    if(-not ($transactionData | Where {$_.Type -eq $type})){continue}

    $stats = ($transactionData | Where {$_.Type -eq $type} | %{$_.'Debit/Credit' -replace "£", ""} | measure -Sum -Average -Maximum -Minimum)
    echo "----------------------------------------"
    echo "Type: $type. ($($transactionTypes[$type]))"
    echo "Total: $($stats.Sum). Average: $($stats.Average). Min: $($stats.Max). Max: $($stats.Max)"

}
echo "----------------------------------------"


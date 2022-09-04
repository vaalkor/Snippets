param(
    [Parameter(Mandatory=$true)][string]$SourceDrive,
    [Parameter(Mandatory=$true)][string]$InputFile,
    [Parameter(Mandatory=$true)][string]$OutputFile
)

$currentFile = $null
$files = [System.Collections.ArrayList]::new()

Get-Content $InputFile | %{
    if($_ -eq "" -and $currentFile){
        $sourceDriveCount = ($currentFile | ?{$_.StartsWith("$SourceDrive`:")}).Count
        if($sourceDriveCount -gt 0 -and $sourceDriveCount -ne $currentFile.Count){
            [void]$files.Add($currentFile)
            $count += 1
        }
        $currentFile = $null
    }
    elseif($_ -ne "" -and -not $currentFile){
        $currentFile = @($_)
    }
    elseif($_ -ne "" -and $currentFile){
        $currentFile += $_
    }
}

echo "Total duplicate files with at least 1 duplicate on the source drive: $($files.Count)"

Set-Content $OutputFile -Value ""

for ($i = 0; $i -lt $files.Count; $i++)
{
    Add-Content -Path $OutputFile -Value "$([string]::Join("`n", $files[$i]))`n"
}

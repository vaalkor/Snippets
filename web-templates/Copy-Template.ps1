
param(
    [ValidateSet("mithril-bootstrap", "plain-js", "typescript", "typescript-mithril-bootstrap")]
    [Parameter(Mandatory=$true)]
    [string]$TemplateType,
    [Parameter(Mandatory=$true)]
    [string]$NewFolderName
)

$sourcePath = Join-Path -Path $PSScriptRoot -ChildPath $TemplateType
$destinationPath = Join-Path -Path (Get-Location) -ChildPath $NewFolderName

if (Test-Path -Path $sourcePath) {
    Copy-Item -Path $sourcePath -Destination $destinationPath -Recurse -Force
    Write-Output "Template copied successfully to $destinationPath"
} else {
    Write-Error "Template type '$TemplateType' does not exist in the current directory."
}

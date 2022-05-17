param(
    [string]$Version,
    [string]$InstallDirectory="C:\Program Files\terraform",
    [switch]$ListVersions,
    [switch]$AdminCopy
)

if($AdminCopy){
    Copy-Item "~/.terraform-version-cache/terraform.exe" $InstallDirectory -Force
}

mkdir "~/.terraform-version-cache" -Force | Out-Null


function Get-Versions {
    $html = (curl "https://releases.hashicorp.com/terraform/").Content
    (Select-String "(?<=>terraform_).*(?=<\/)" -input $html -AllMatches).Matches | %{$_.Value} | Sort-Object {(--$script:i)}
}

if($ListVersions){
    "============================="
    "Available terraform versions:"
    "============================="
    Get-Versions
    exit 0
}

if(-not $Version){
    echo "No `$Version parameter provided! Quitting."
    exit 1
}

$versions = Get-Versions

if(-not ($versions -contains $Version)){
    "`nVersion '$Version' not found. Run script with parameter -ListVersions to see available versions!.
(They are pulled from https://releases.hashicorp.com/terraform/)`n"
    exit 1
}

if(-not (ls "~/.terraform-version-cache" -Filter "terraform_$($Version)_windows_amd64.zip")){
    curl "https://releases.hashicorp.com/terraform/$($Version)/terraform_$($Version)_windows_amd64.zip" `
        -OutFile "~/.terraform-version-cache/terraform_$($Version)_windows_amd64.zip"
}

Expand-Archive "~/.terraform-version-cache/terraform_$($Version)_windows_amd64.zip"  -DestinationPath "~/.terraform-version-cache" -Force

try{
    Copy-Item "~/.terraform-version-cache/terraform.exe" $InstallDirectory -ErrorAction Stop
}catch{
    if(([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)){
        throw
    }
    if($_.Exception.GetType() -ne [System.UnauthorizedAccessException]){
        throw
    }
    echo "We got an access denied exception when trying to copy the file. Relaunching script as admin."
    # Relaunch as an elevated process:
    Start-Process powershell.exe "-File",("$($MyInvocation.MyCommand.Path) --AdminCopy --InstallLocation '$InstallDirectory'") -Verb RunAs
    exit
}


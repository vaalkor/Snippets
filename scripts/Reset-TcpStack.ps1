if(-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
    Start-Process powershell.exe "-File",("$($MyInvocation.MyCommand.Path)") -Verb RunAs
    exit
}

ipconfig /release
ipconfig /flushdns
ipconfig /renew
netsh int ip reset
netsh winsock reset

Restart-Computer
@echo off
TITLE Hamachi Metric to 1 and Private network
color 0a

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------

netsh interface ipv4 set interface "Hamachi" metric=1 > nul
netsh interface ipv4 show interfaces interface=hamachi | findstr /i "metric"
echo.

powershell.exe -ExecutionPolicy Bypass -NoExit -Command  "& {$result = reg query \"hklm\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Signatures\Unmanaged\010103000F0000F0080000000F0000F0DA4A9AABECDFC5CE7D0E9B0D35754601C203932948837AFDA91B6942C8E20892\" /v \"ProfileGuid\";$myarray = $result -split \" \";$path = \"hklm\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Profiles\\\" + $myarray[15];reg add $path /v Category /t REG_DWORD /d 1 /f;reg add $path /v CategoryType /t REG_DWORD /d 0 /f | out-null"}

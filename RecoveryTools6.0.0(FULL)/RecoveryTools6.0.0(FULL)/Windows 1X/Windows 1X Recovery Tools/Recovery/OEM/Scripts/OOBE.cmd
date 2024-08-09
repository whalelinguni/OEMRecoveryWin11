@Echo Off
%~d0%
CD "%~dp0%"
CLS
ECHO *************************************
ECHO Testing ADMIN rights
ECHO *************************************
ECHO Test>C:\AdminTest.txt
IF NOT EXIST C:\AdminTest.txt (
ECHO *************************************
ECHO Error!
ECHO *************************************
ECHO Please run this script with 
ECHO administrator access!
ECHO *************************************
PAUSE
EXIT
)
DEL C:\AdminTest.txt
CLS

ECHO *********************************
ECHO Tagging OOBE in the log file
ECHO *********************************
ECHO %DATE%-%TIME%-OOBE-Start >>C:\Recovery\OEM\Logs\Logfile.txt


ECHO *********************************
ECHO Enabling File Browser in WinRE
ECHO *********************************
C:
CD \
CD RECOVERY
CD OEM
CD SCRIPTS
START "WinRE Update" /MIN /WAIT WinREUpdate.cmd

ECHO *********************************
ECHO Enabling WinRE
ECHO *********************************
REAGENTC /ENABLE

ECHO *********************************
ECHO Creating Icons
ECHO *********************************
START /WAIT "Creating Icons" "C:\Recovery\OEM\AutoIt\AutoIt3_%PROCESSOR_ARCHITECTURE%.EXE" "C:\Recovery\OEM\Menu\CreateShortcut.au3" "C:\Recovery\OEM\AutoIt\AutoIt3_%PROCESSOR_ARCHITECTURE%.EXE" "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Recovery Tools.lnk" "C:\Recovery\OEM\Menu" "C:\Recovery\OEM\Menu\Recovery.au3" "Computer Recovery Tools" "C:\Recovery\OEM\Menu\appicon.ico"
START /WAIT "Creating Icons" "C:\Recovery\OEM\AutoIt\AutoIt3_%PROCESSOR_ARCHITECTURE%.EXE" "C:\Recovery\OEM\Menu\CreateShortcut.au3" "C:\Recovery\OEM\AutoIt\AutoIt3_%PROCESSOR_ARCHITECTURE%.EXE" "C:\Users\Public\Desktop\Recovery Tools.lnk" "C:\Recovery\OEM\Menu" "C:\Recovery\OEM\Menu\Recovery.au3" "Computer Recovery Tools" "C:\Recovery\OEM\Menu\appicon.ico"

ECHO *********************************
ECHO Enabling System Restore
ECHO *********************************
PowerShell -ExecutionPolicy Unrestricted -File "C:\Recovery\OEM\Scripts\EnableSystemRestore.ps1"

ECHO *********************************
ECHO Installing APPX/MSIX files
ECHO *********************************
for /f %%I in ('dir C:\Recovery\OEM\Appx\*.* /b /on') do (dism /online /add-provisionedappxpackage /packagepath:"C:\Recovery\OEM\Appx\%%I" /skiplicense)
for /f %%I in ('dir C:\Recovery\OEM\Appx\*.* /b /on') do (dism /online /add-package /packagepath:"C:\Recovery\OEM\Appx\%%I")

ECHO *********************************
ECHO *********************************
ECHO *********************************
ECHO Executing custom scripts
ECHO *********************************
ECHO *********************************
ECHO *********************************
START "OOBE - Custom" /MIN /WAIT C:\Recovery\OEM\Scripts\OOBE-Custom.cmd

:QUIT
ECHO %DATE%-%TIME%-OOBE-End >>C:\Recovery\OEM\Logs\Logfile.txt
EXIT 0
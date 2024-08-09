@Echo Off
IF NOT EXIST "%CD%\Recovery\OEM\ScanState\amd64\scanstate.exe" GOTO MISSINGFILES
IF NOT EXIST "%CD%\Recovery\OEM\ScanState\x86\scanstate.exe" GOTO MISSINGFILES
IF NOT EXIST "%CD%\Recovery\OEM\ScanState\amd64\Config_AppsAndSettings.xml" GOTO MISSINGFILES
IF NOT EXIST "%CD%\Recovery\OEM\ScanState\x86\Config_AppsAndSettings.xml" GOTO MISSINGFILES
XCOPY ".\Recovery\*.*" C:\Recovery\ /sevhky
ATTRIB -S -R -H C:\Recovery
ATTRIB -S -R -H C:\Recovery /S
icacls C:\Recovery /reset /T /C
icacls C:\Recovery /inheritance:r /grant:r SYSTEM:(OI)(CI)(F) /grant:r *S-1-5-32-544:(OI)(CI)(F) /grant:r *S-1-5-32-545:(OI)(CI)(RX) /C
ATTRIB +S +H C:\Recovery

CLS
ECHO ************************************
ECHO Add-On Options
ECHO ************************************
ECHO This package include the following
ECHO add-on in the recovery menu:
ECHO - ClamWin Antivirus
ECHO - Kickass Undelete
ECHO ************************************
CHOICE /C 12 /M "1=Install the add-on 2=Do not install the add-on"
IF ERRORLEVEL 2 GOTO DELETE
IF ERRORLEVEL 1 GOTO KEEP

:DELETE
RD /S /Q C:\Recovery\OEM\Menu\AddOn
DEL C:\Recovery\OEM\Menu\Settings.ini
REN C:\Recovery\OEM\Menu\Settings.NoAddOn.ini Settings.ini
GOTO END

:KEEP
DEL C:\Recovery\OEM\Menu\Settings.NoAddOn.ini
GOTO END

:END
CLS
ECHO ************************************
ECHO Base files where copied successfully
ECHO ************************************
ECHO Please copy
ECHO ReCreatePartitions.txt
ECHO and
ECHO ResetConfig.xml
ECHO in C:\Recovery\OEM
ECHO ====================================
ECHO Examples files can be found under
ECHO C:\Recovery\OEM\Settings
ECHO ====================================
ECHO To complete the installation,
ECHO run Sysprep.cmd from
ECHO C:\Recovery\OEM
ECHO ************************************
ECHO %DATE%-%TIME%-Tools Installation >>C:\Recovery\OEM\Logs\Logfile.txt
PAUSE
EXIT 0

:MISSINGFILES
ECHO ************************************
ECHO Scanstate files are missing
ECHO in .\Recovery\OEM\Scanstate\AMD64
ECHO or in .\Recovery\OEM\Scanstate\X86
ECHO Also check for Config_AppsAndSettings.xml
ECHO in both Scanstate folders as this
ECHO file is now required.
ECHO ************************************
PAUSE
EXIT 1
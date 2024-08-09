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
DEL C:\Recovery\OEM\Logs\Logfile.txt
START "Prevent Sleep" "%CD%\AutoIT\AutoIt3_%PROCESSOR_ARCHITECTURE%.exe" "%CD%\PreventSleep.Au3"

IF EXIST C:\Recovery\OEM\Find.Me EXIT 2
ECHO %DATE%-%TIME%-Sysprep-Start >>C:\Recovery\OEM\Logs\Logfile.txt
ECHO *****************************
ECHO Checking files
ECHO *****************************
IF NOT EXIST C:\Recovery\OEM\SCANSTATE\%PROCESSOR_ARCHITECTURE%\scanstate.exe GOTO MISSINGFILES
IF NOT EXIST C:\Recovery\OEM\ScanState\%PROCESSOR_ARCHITECTURE%\Config_AppsAndSettings.xml GOTO MISSINGFILES
IF NOT EXIST C:\Recovery\OEM\ReCreatePartitions.txt GOTO MISSINGFILES
IF NOT EXIST C:\Recovery\OEM\ResetConfig.xml GOTO MISSINGFILES

CLS
ECHO *****************************
ECHO Finding OS Drive and partition
ECHO *****************************
SET OSDRV=-1
wmic path win32_bootconfiguration get caption /value |find /i "caption" > "%temp%\wmic_output.txt"
FOR /F "tokens=1,2,3,4,* delims=\" %%I in (%temp%\wmic_output.txt) do @SET OSDRV=%%K
DEL "%temp%\wmic_output.txt"
SET OSDRV=%OSDRV:~8%
IF "%OSDRV%"=="-1" GOTO BOOTDRIVERROR
ECHO Windows is on DISK %OSDRV%
CLS

ECHO *****************************
ECHO APPX Apps Injection
ECHO *****************************
ECHO If you want to automatically install Appx/AppxBundle/MSIX apps after OOBE, add
ECHO all the required files in the following folder : 
ECHO - C:\Recovery\OEM\Appx
ECHO.
ECHO The files will be installed in alphabetical order so make sure pre-requisites are
ECHO in order.
ECHO.
ECHO Files can be downloaded with the help of : https://store.rg-adguard.net/
ECHO *****************************
PAUSE
CLS

ECHO *****************************
ECHO WinRE Drivers Injection
ECHO *****************************
ECHO If your computer requires special drivers (SATA, Octane, Touch Screen, etc.), copy them
ECHO in the following folder : 
ECHO - C:\Recovery\OEM\WinREFiles\drivers
ECHO *****************************
CHOICE /c 12 /m "1=Do not add drivers to WinRE 2=Add drivers to WinRE"
IF ERRORLEVEL 2 SET WINREDRV=1
IF ERRORLEVEL 1 SET WINREDRV=0
IF "%WINREDRV%"=="1" ECHO %DATE%-%TIME%-Drivers injection required>>C:\Recovery\OEM\Logs\Logfile.txt
IF "%WINREDRV%"=="0" ECHO %DATE%-%TIME%-Drivers injection NOT required>>C:\Recovery\OEM\Logs\Logfile.txt
CLS

ECHO *****************************
ECHO Generalize the image
ECHO *****************************
ECHO The generelization process of an image clean all account and prepare the
ECHO image for replication. It is a requirement for support from Microsoft
ECHO when creating image.
ECHO.
ECHO Still, it can happens that the generalize option break some applications or
ECHO drivers and make the image unusable. If you already tried the generalize option
ECHO and you had some problem you may try to skip it.
ECHO.
ECHO No support will be provided in case the option is skipped!
ECHO.
ECHO WARNING : Full image capture cannot be used if generalize is not used!
ECHO *****************************
CHOICE /c 12 /m "1=Generalize (Reccomended) 2=Do not generalize"
IF ERRORLEVEL 2 SET GENERALIZE=0
IF ERRORLEVEL 1 SET GENERALIZE=1
IF "%GENERALIZE%"=="1" ECHO %DATE%-%TIME%-Image generalization requested>>C:\Recovery\OEM\Logs\Logfile.txt
IF "%GENERALIZE%"=="0" ECHO %DATE%-%TIME%-Image generalization SKIPPED>>C:\Recovery\OEM\Logs\Logfile.txt
CLS

ECHO *****************************
ECHO Updates cleanup
ECHO *****************************
ECHO You can choose to cleanup the currently installed updates.
ECHO This will reduce the image file but will prevent uninstallation
ECHO of theses updates.
ECHO *****************************
CHOICE /c 12 /m "1=Cleanup updates (Reccomended) 2=Do not cleanup updates"
IF ERRORLEVEL 2 SET CLEANUP=0
IF ERRORLEVEL 1 SET CLEANUP=1
IF "%CLEANUP%"=="1" ECHO %DATE%-%TIME%-Updates cleanup requested>>C:\Recovery\OEM\Logs\Logfile.txt
IF "%CLEANUP%"=="0" ECHO %DATE%-%TIME%-Updates cleanup SKIPPED>>C:\Recovery\OEM\Logs\Logfile.txt
CLS

SET MODE=SYSPREP
IF "%GENERALIZE%"=="0" GOTO FINALVALIDATION
FOR /F "tokens=1,2,3 skip=2" %%I in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ReleaseId') do @SET BUILD=%%K
IF "%BUILD%" GEQ "1703" (ECHO ************************
ECHO Recovery option
ECHO ************************
choice /c 12 /m "1=Full image (WIM) 2=Push-button reset only (Rebuild from current Windows)"
IF ERRORLEVEL 2 SET MODE=SYSPREP
IF ERRORLEVEL 1 SET MODE=FULL)
IF "%MODE%"=="SYSPREP" ECHO %DATE%-%TIME%-Push-button reset option requested>>C:\Recovery\OEM\Logs\Logfile.txt
IF "%MODE%"=="FULL" ECHO %DATE%-%TIME%-Full image capture requested>>C:\Recovery\OEM\Logs\Logfile.txt
CLS

:FINALVALIDATION
ECHO *****************************
ECHO Final validation
ECHO *****************************
ECHO Windows drive is : %OSDRV%
IF "%WINREDRV%"=="1" ECHO Add drivers to WinRE : TRUE
IF "%WINREDRV%"=="0" ECHO Add drivers to WinRE : FALSE
IF "%CLEANUP%"=="1" ECHO Updates cleanup : TRUE
IF "%CLEANUP%"=="0" ECHO Updates cleanup : FALSE
IF "%GENERALIZE%"=="1" ECHO Image generalization : TRUE
IF "%GENERALIZE%"=="0" ECHO Image generalization : FALSE
IF "%MODE%"=="SYSPREP" ECHO Image mode : Push-button reset
IF "%MODE%"=="FULL" ECHO Image mode : Full
ECHO *****************************
choice /c 12 /m "1=Confirm 2=Quit"
IF ERRORLEVEL 2 EXIT
IF ERRORLEVEL 1 GOTO START

:START
CLS
ECHO *****************************
ECHO Reactivation AutoDownload
ECHO *****************************
REG DELETE HKLM\SOFTWARE\Policies\Microsoft\WindowsStore /v AutoDownload /f

ECHO *****************************
ECHO Enabling Local Account (Windows 11)
ECHO *****************************
REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE /v BypassNRO /t REG_DWORD /d 1 /f

IF "%CLEANUP%"=="1" (ECHO *****************************
ECHO Marking updates as permanent
ECHO *****************************
DISM.exe /Online /Cleanup-Image /StartComponentCleanup /ResetBase)


ECHO *****************************
ECHO Capturing softwares
ECHO *****************************
C:
CD \
CD Recovery
CD OEM
CD ScanState
CD %PROCESSOR_ARCHITECTURE%
scanstate.exe /apps /config:C:\Recovery\OEM\ScanState\%PROCESSOR_ARCHITECTURE%\Config_AppsAndSettings.xml /ppkg C:\Recovery\Customizations\Recovery.ppkg /o /c /v:13
CD ..
CD ..
IF NOT EXIST C:\Recovery\Customizations\Recovery.ppkg (
ECHO.
ECHO ********************************
ECHO Error!
ECHO ScanState failed!
ECHO Process abborted!
ECHO ********************************
ECHO %DATE%-%TIME%-Sysprep-Error >>C:\Recovery\OEM\Logs\Logfile.txt
PAUSE
TASKKILL /IM AutoIt3_%PROCESSOR_ARCHITECTURE%.exe /F
EXIT 1
)


IF "%MODE%"=="FULL" GOTO CAPTURE
IF "%MODE%"=="SYSPREP" GOTO SYSPREPONLY


:CAPTURE
ECHO %DATE%-%TIME%-Full capture selected >>C:\Recovery\OEM\Logs\Logfile.txt
ECHO ************************
ECHO Enabling WinRE
ECHO ************************
REAGENTC /ENABLE /AUDITMODE
REAGENTC /BOOTTORE


ECHO %DATE%-%TIME%-Cleaning old files >>C:\Recovery\OEM\Logs\Logfile.txt
ECHO ************************
ECHO Cleaning Old Files
ECHO ************************
MD C:\Recovery\OEM\Temp\
DEL C:\Recovery\OEM\Temp\FindRecovery.txt
DEL C:\Recovery\OEM\Temp\MountRecovery.txt
DEL C:\Recovery\OEM\Temp\UnmountRecovery.txt
IF NOT EXIST C:\Recovery\OEM\ResetConfig.xml GOTO MISSINGFILES


ECHO %DATE%-%TIME%-Mounting recovery partition >>C:\Recovery\OEM\Logs\Logfile.txt
ECHO ****************************
ECHO Mounting Recovery Partition
ECHO ****************************
TYPE C:\Recovery\OEM\ResetConfig.xml | find /i "WindowsREPartition" >C:\Recovery\OEM\Temp\FindRecovery.txt
FOR /f "delims=>< tokens=3" %%I in (C:\Recovery\OEM\Temp\FindRecovery.txt) do SET VOL=%%I
DEL C:\Recovery\OEM\Temp\FindRecovery.txt
ECHO SELECT DISK %OSDRV% >C:\Recovery\OEM\Temp\MountRecovery.txt
ECHO SELECT PARTITION %VOL% >>C:\Recovery\OEM\Temp\MountRecovery.txt
ECHO ASSIGN LETTER R >>C:\Recovery\OEM\Temp\MountRecovery.txt
ECHO SELECT DISK %OSDRV% >C:\Recovery\OEM\Temp\UnMountRecovery.txt
ECHO SELECT PARTITION %VOL% >>C:\Recovery\OEM\Temp\UnMountRecovery.txt
ECHO REMOVE >>C:\Recovery\OEM\Temp\UnMountRecovery.txt
DISKPART /S C:\Recovery\OEM\Temp\MountRecovery.txt

IF "%WINREDRV%"=="1" (ECHO %DATE%-%TIME%-Injecting drivers in WinRE >>C:\Recovery\OEM\Logs\Logfile.txt
ECHO ****************************
ECHO Injecting Drivers
ECHO ****************************
MKDIR C:\Recovery\OEM\Temp\Mount
DISM /Mount-Wim /WimFile:R:\Recovery\WindowsRE\WinRE.WIM /MountDir:C:\Recovery\OEM\Temp\Mount /Index:1
DISM /Image:C:\Recovery\OEM\Temp\Mount /Add-Driver /Driver:C:\Recovery\OEM\WinREFiles\drivers /Recurse
DISM /UnMount-Wim /MountDir:C:\Recovery\OEM\Temp\Mount /Commit
RMDIR C:\Recovery\OEM\Temp\Mount)


ECHO %DATE%-%TIME%-Preparing recovery files >>C:\Recovery\OEM\Logs\Logfile.txt
ECHO ****************************
ECHO Preparing Recovery Files
ECHO ****************************
XCOPY /VHKY R:\Recovery\WindowsRE\WinRE.wim C:\Recovery\OEM\
XCOPY /VHKY R:\Recovery\WindowsRE\Boot.sdi C:\Recovery\OEM\
XCOPY /VHKY R:\Recovery\WindowsRE\WinRE.wim C:\Recovery\OEM\Image\%PROCESSOR_ARCHITECTURE%\sources\
XCOPY /VHKY C:\Recovery\OEM\ResetConfig.xml C:\Recovery\OEM\Image\%PROCESSOR_ARCHITECTURE%\sources\
XCOPY /VHKY C:\Recovery\OEM\ReCreatePartitions.txt C:\Recovery\OEM\Image\%PROCESSOR_ARCHITECTURE%\sources\
ATTRIB -S -R -H C:\Recovery\OEM\Image\%PROCESSOR_ARCHITECTURE%\sources\*.* /S
ATTRIB -S -R -H C:\Recovery\OEM\WinRE.wim
ATTRIB -S -R -H C:\Recovery\OEM\Boot.sdi
REN C:\Recovery\OEM\Image\%PROCESSOR_ARCHITECTURE%\sources\WinRE.wim Boot.wim
REN C:\Recovery\OEM\WinRE.wim Capture.wim
COPY C:\Recovery\OEM\Image\%PROCESSOR_ARCHITECTURE%\sources\Boot.wim C:\Recovery\OEM\Image\%PROCESSOR_ARCHITECTURE%\sources\Boot2.wim


ECHO %DATE%-%TIME%-Unmounting recovery partition >>C:\Recovery\OEM\Logs\Logfile.txt
ECHO ******************************
ECHO Unmounting Recovery Partition
ECHO ******************************
DISKPART /S C:\Recovery\OEM\Temp\UnmountRecovery.txt


ECHO %DATE%-%TIME%-Mounting capture image >>C:\Recovery\OEM\Logs\Logfile.txt
ECHO ****************************
ECHO Mounting WINRE
ECHO ****************************
MD C:\Recovery\OEM\Temp\Mount
DISM /Mount-Wim /WimFile:C:\Recovery\OEM\Capture.wim /Index:1 /MountDir:C:\Recovery\OEM\Temp\Mount


ECHO %DATE%-%TIME%-Updating capture image >>C:\Recovery\OEM\Logs\Logfile.txt
ECHO ****************************
ECHO Updating WINRE
ECHO ****************************
ATTRIB -S -R -H C:\Recovery\OEM\WinREFiles\capture\*.* /S
ATTRIB -S -R -H C:\Recovery\OEM\Temp\Mount\Windows\System32\WINPESHL.INI
XCOPY /SEVHKY C:\Recovery\OEM\WinREFiles\capture\*.* C:\Recovery\OEM\Temp\Mount\


ECHO %DATE%-%TIME%-Unmounting capture image >>C:\Recovery\OEM\Logs\Logfile.txt
ECHO ****************************
ECHO Unmounting WINRE
ECHO ****************************
DISM /UnMount-Wim /MountDir:C:\Recovery\OEM\Temp\Mount /Commit
RMDIR C:\Recovery\OEM\Temp\Mount


ECHO %DATE%-%TIME%-Cleaning old files >>C:\Recovery\OEM\Logs\Logfile.txt
ECHO ************************
ECHO Cleaning Old Files
ECHO ************************
DEL C:\Recovery\OEM\Temp\FindRecovery.txt
DEL C:\Recovery\OEM\Temp\MountRecovery.txt
DEL C:\Recovery\OEM\Temp\UnmountRecovery.txt
RD /S /Q C:\Recovery\OEM\Temp\


ECHO %DATE%-%TIME%-Running sysprep >>C:\Recovery\OEM\Logs\Logfile.txt
ECHO *****************************
ECHO Running Sysprep
ECHO *****************************
TASKKILL /IM SYSPREP.EXE /F /T
TASKKILL /IM WMPNETWK.EXE /F /T
IF "%GENERALIZE%"=="1" START /WAIT C:\Windows\System32\Sysprep\SysPrep.exe /generalize /oobe /quit /unattend:C:\Recovery\OEM\XML\UnAttend.%PROCESSOR_ARCHITECTURE%.Xml
IF "%GENERALIZE%"=="0" START /WAIT C:\Windows\System32\Sysprep\SysPrep.exe /oobe /quit /unattend:C:\Recovery\OEM\XML\UnAttend.%PROCESSOR_ARCHITECTURE%.Xml
ECHO %DATE%-%TIME%-Sysprep-End >>C:\Recovery\OEM\Logs\Logfile.txt
ECHO Do not delete! >Find.Me


ECHO %DATE%-%TIME%-Setting boot option to capture image >>C:\Recovery\OEM\Logs\Logfile.txt
ECHO *****************************
ECHO Adding capture image
ECHO *****************************
BCDEDIT /export C:\Recovery\OEM\BCD.Sav
FOR /F "delims={} tokens=2" %%I IN ('BCDEDIT.EXE /create /application OSLOADER /d Capture') DO SET OSGUID=%%I
FOR /F "delims={} tokens=2" %%I IN ('BCDEDIT.EXE /create /device /d Capture') DO SET RAMGUID=%%I
FOR /F "tokens=1,2" %%I in ('bcdedit /enum {current}') do @IF "%%I"=="path" SET WINLOAD=%%J
SET OSGUID={%OSGUID%}
SET RAMGUID={%RAMGUID%}
bcdedit /set %OSGUID% device ramdisk=[C:]\Recovery\OEM\Capture.wim,%RAMGUID%
bcdedit /set %OSGUID% osdevice ramdisk=[C:]\Recovery\OEM\Capture.wim,%RAMGUID%
bcdedit /set %OSGUID% path %WINLOAD%
bcdedit /set %OSGUID% locale en-us
bcdedit /set %OSGUID% inherit {bootloadersettings}
bcdedit /set %OSGUID% systemroot \windows
bcdedit /set %OSGUID% detecthal Yes
bcdedit /set %OSGUID% winpe Yes
bcdedit /set %OSGUID% ems No
bcdedit /set %RAMGUID% ramdisksdidevice partition=C:
bcdedit /set %RAMGUID% ramdisksdipath \Recovery\OEM\BOOT.SDI
bcdedit /set {bootmgr} displayorder %OSGUID% /addlast
bcdedit /set {bootmgr} locale en-us
bcdedit /set {current} locale en-us
bcdedit /delete {current}


ECHO %DATE%-%TIME%-Rebooting >>C:\Recovery\OEM\Logs\Logfile.txt
ECHO *****************************
ECHO Computer will reboot to capture image
ECHO *****************************
RD /S /Q C:\Recovery\OEM\ScanState
SHUTDOWN -R -T 30
TASKKILL /IM AutoIt3_%PROCESSOR_ARCHITECTURE%.exe /F
EXIT 0


:SYSPREPONLY
ECHO %DATE%-%TIME%-Push-Button option selected (no full image) >>C:\Recovery\OEM\Logs\Logfile.txt
ECHO ************************
ECHO Enabling WinRE
ECHO ************************
REAGENTC /ENABLE /AUDITMODE

ECHO %DATE%-%TIME%-Cleaning old files >>C:\Recovery\OEM\Logs\Logfile.txt
ECHO ************************
ECHO Cleaning Old Files
ECHO ************************
MD C:\Recovery\OEM\Temp\
DEL C:\Recovery\OEM\Temp\FindRecovery.txt
DEL C:\Recovery\OEM\Temp\MountRecovery.txt
DEL C:\Recovery\OEM\Temp\UnmountRecovery.txt
IF NOT EXIST C:\Recovery\OEM\ResetConfig.xml GOTO MISSINGFILES


ECHO %DATE%-%TIME%-Mounting recovery partition >>C:\Recovery\OEM\Logs\Logfile.txt
ECHO ****************************
ECHO Mounting Recovery Partition
ECHO ****************************
TYPE C:\Recovery\OEM\ResetConfig.xml | find /i "WindowsREPartition" >C:\Recovery\OEM\Temp\FindRecovery.txt
FOR /f "delims=>< tokens=3" %%I in (C:\Recovery\OEM\Temp\FindRecovery.txt) do SET VOL=%%I
DEL C:\Recovery\OEM\Temp\FindRecovery.txt
ECHO SELECT DISK %OSDRV% >C:\Recovery\OEM\Temp\MountRecovery.txt
ECHO SELECT PARTITION %VOL% >>C:\Recovery\OEM\Temp\MountRecovery.txt
ECHO ASSIGN LETTER R >>C:\Recovery\OEM\Temp\MountRecovery.txt
ECHO SELECT DISK %OSDRV% >C:\Recovery\OEM\Temp\UnMountRecovery.txt
ECHO SELECT PARTITION %VOL% >>C:\Recovery\OEM\Temp\UnMountRecovery.txt
ECHO REMOVE >>C:\Recovery\OEM\Temp\UnMountRecovery.txt
DISKPART /S C:\Recovery\OEM\Temp\MountRecovery.txt


IF "%WINREDRV%"=="1" (ECHO %DATE%-%TIME%-Injecting drivers in WinRE >>C:\Recovery\OEM\Logs\Logfile.txt
ECHO ****************************
ECHO Injecting Drivers
ECHO ****************************
MKDIR C:\Recovery\OEM\Temp\Mount
DISM /Mount-Wim /WimFile:R:\Recovery\WindowsRE\WinRE.WIM /MountDir:C:\Recovery\OEM\Temp\Mount /Index:1
DISM /Image:C:\Recovery\OEM\Temp\Mount /Add-Driver /Driver:C:\Recovery\OEM\WinREFiles\drivers /Recurse
DISM /UnMount-Wim /MountDir:C:\Recovery\OEM\Temp\Mount /Commit
RMDIR C:\Recovery\OEM\Temp\Mount)


ECHO %DATE%-%TIME%-Unmounting recovery partition >>C:\Recovery\OEM\Logs\Logfile.txt
ECHO ******************************
ECHO Unmounting Recovery Partition
ECHO ******************************
DISKPART /S C:\Recovery\OEM\Temp\UnmountRecovery.txt


ECHO %DATE%-%TIME%-Running sysprep >>C:\Recovery\OEM\Logs\Logfile.txt
ECHO *****************************
ECHO Running Sysprep
ECHO *****************************
TASKKILL /IM SYSPREP.EXE /F /T
TASKKILL /IM WMPNETWK.EXE /F /T
IF "%GENERALIZE%"=="1" START /WAIT C:\Windows\System32\Sysprep\SysPrep.exe /generalize /oobe /quit /unattend:C:\Recovery\OEM\XML\UnAttend.%PROCESSOR_ARCHITECTURE%.Xml
IF "%GENERALIZE%"=="0" START /WAIT C:\Windows\System32\Sysprep\SysPrep.exe /oobe /quit /unattend:C:\Recovery\OEM\XML\UnAttend.%PROCESSOR_ARCHITECTURE%.Xml
ECHO %DATE%-%TIME%-Sysprep-End >>C:\Recovery\OEM\Logs\Logfile.txt
ECHO Do not delete! >Find.Me


ECHO %DATE%-%TIME%-Cleaning old files >>C:\Recovery\OEM\Logs\Logfile.txt
ECHO ************************
ECHO Cleaning Old Files
ECHO ************************
DEL C:\Recovery\OEM\Temp\FindRecovery.txt
DEL C:\Recovery\OEM\Temp\MountRecovery.txt
DEL C:\Recovery\OEM\Temp\UnmountRecovery.txt
RD /S /Q C:\Recovery\OEM\Temp\


ECHO %DATE%-%TIME%-Rebooting >>C:\Recovery\OEM\Logs\Logfile.txt
ECHO *****************************
ECHO Computer will shutdown
ECHO *****************************
RD /S /Q C:\Recovery\OEM\ScanState
SHUTDOWN -S -T 60
TASKKILL /IM AutoIt3_%PROCESSOR_ARCHITECTURE%.exe /F
EXIT 0


:BOOTDRIVERROR
ECHO *****************************
ECHO Missing files
ECHO *****************************
ECHO Cannot identify OS partition
ECHO and disk.
PAUSE
DEL Find.Me
TASKKILL /IM AutoIt3_%PROCESSOR_ARCHITECTURE%.exe /F
EXIT 1

:MISSINGFILES
ECHO *****************************
ECHO Missing files
ECHO *****************************
ECHO Scanstate files are missing
ECHO OR
ECHO ResetConfig.xml is missing
ECHO OR
ECHO ReCreatePartitions.txt is missing
ECHO OR
ECHO Config_AppsAndSettings.xml is missing
PAUSE
DEL Find.Me
TASKKILL /IM AutoIt3_%PROCESSOR_ARCHITECTURE%.exe /F
EXIT 1
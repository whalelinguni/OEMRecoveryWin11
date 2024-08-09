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


IF NOT EXIST C:\Recovery\OEM\Image\install.wim IF NOT EXIST C:\Recovery\OEM\Image\install.swm GOTO MISSINGIMAGE


ECHO ***********************************
ECHO Validating sources files
ECHO ***********************************
IF NOT EXIST C:\Recovery\OEM\Image\%PROCESSOR_ARCHITECTURE%\sources\boot.wim GOTO MISSINGIMAGE
IF NOT EXIST C:\Recovery\OEM\Image\%PROCESSOR_ARCHITECTURE%\sources\boot2.wim GOTO MISSINGIMAGE


ECHO ****************************
ECHO Finding Assigned Letters
ECHO ****************************
SET BOOT=-1
SET DATA=-1
FOR /D %%I IN (D E F G H I J K L M N O P Q R S T U V W X Y Z) DO (
IF EXIST %%I:\Boot.Tag SET BOOT=%%I
IF EXIST %%I:\Recovery.Tag SET DATA=%%I
)
IF "%BOOT%"=="-1" GOTO DRIVENOTFOUND
IF "%DATA%"=="-1" GOTO DRIVENOTFOUND


ECHO ***********************************
ECHO Creating folder / Mount
ECHO ***********************************
IF NOT EXIST "%TEMP%\Recovery" MD "%TEMP%\Recovery"
IF NOT EXIST "%TEMP%\RecoveryMount" MD "%TEMP%\RecoveryMount"
XCOPY C:\Recovery\OEM\Image\%PROCESSOR_ARCHITECTURE%\*.* "%TEMP%\Recovery\" /SEVHK
DISM /Mount-Wim /WimFile:%TEMP%\Recovery\sources\boot2.wim /Index:1 /MountDir:"%TEMP%\RecoveryMount"


ECHO ***********************************
ECHO Copying recovery tools
ECHO ***********************************
ATTRIB -S -R -H "%TEMP%\RecoveryMount\Windows\System32\WINPESHL.INI"
XCOPY /SEVHKY C:\Recovery\OEM\WinREFiles\recovery\*.* "%TEMP%\RecoveryMount\"
COPY C:\Recovery\OEM\Menu\Settings.ini "%TEMP%\RecoveryMount\Recovery\Settings.ini"
COPY /Y "%TEMP%\RecoveryMount\Windows\System32\WINPESHL.%PROCESSOR_ARCHITECTURE%.INI" "%TEMP%\RecoveryMount\Windows\System32\WINPESHL.INI"


ECHO ***********************************
ECHO UnMount
ECHO ***********************************
DISM /UnMount-Wim /MountDir:"%TEMP%\RecoveryMount" /Commit
RD /S /Q "%TEMP%\RecoveryMount"


ECHO ****************************
ECHO Copying base files
ECHO ****************************
ROBOCOPY "%TEMP%\Recovery" %BOOT%:\ *.* /E /W:1 /R:5
IF %ERRORLEVEL% LSS 8 GOTO END
IF EXIST "%TEMP%\Recovery" RD /S /Q "%TEMP%\Recovery"
IF EXIST "%TEMP%\RecoveryMount" RD /S /Q "%TEMP%\RecoveryMount"
EXIT 1


:END
IF EXIST "%TEMP%\Recovery" RD /S /Q "%TEMP%\Recovery"
IF EXIST "%TEMP%\RecoveryMount" RD /S /Q "%TEMP%\RecoveryMount"
EXIT 0


:MISSINGIMAGE
IF EXIST "%TEMP%\Recovery" RD /S /Q "%TEMP%\Recovery"
IF EXIST "%TEMP%\RecoveryMount" RD /S /Q "%TEMP%\RecoveryMount"
CLS
ECHO ***********************************
ECHO No image exist
ECHO Cannot continue
ECHO ***********************************
TIMEOUT 5
EXIT 2


:DRIVENOTFOUND
IF EXIST "%TEMP%\Recovery" RD /S /Q "%TEMP%\Recovery"
IF EXIST "%TEMP%\RecoveryMount" RD /S /Q "%TEMP%\RecoveryMount"
CLS
ECHO ***********************************
ECHO Cannot find USB drive
ECHO Cannot continue
ECHO ***********************************
TIMEOUT 5
EXIT 3
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


:COPYIMG
ECHO ****************************
ECHO Copying recovery image
ECHO ****************************
MKDIR %DATA%:\sources
IF EXIST C:\Recovery\OEM\Image\Install.wim (ROBOCOPY C:\Recovery\OEM\Image %DATA%:\sources Install.wim /W:1 /R:5
IF %ERRORLEVEL% LSS 8 EXIT 0)
IF EXIST C:\Recovery\OEM\Image\Install.swm (ROBOCOPY C:\Recovery\OEM\Image %DATA%:\sources Install*.swm /W:1 /R:5
IF %ERRORLEVEL% LSS 8 EXIT 0)
EXIT 1


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
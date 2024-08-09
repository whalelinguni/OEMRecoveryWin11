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

IF EXIST C:\Recovery\OEM\Image\Install.wim GOTO START
IF EXIST C:\Recovery\OEM\Image\Install.swm GOTO START
GOTO MISSINGFILES

:START
ECHO *****************************
ECHO Delete recovery image
ECHO *****************************
ECHO Do you want to completly delete the full recovery image made by you system integrator?
ECHO Doing so will prevent you from creating a recovery media using this image.
ECHO You will still be able to create a recovery media using the curent build/drivers of Windows.
ECHO *****************************
CHOICE /C YN /M "Y=Delete the image N=Do not delete the image"
IF ERRORLEVEL 2 EXIT 0
IF ERRORLEVEL 1 GOTO DELETE
GOGO START

:DELETE
ECHO %DATE%-%TIME%-Full Image delete >>C:\Recovery\OEM\Logs\Logfile.txt
ATTRIB -S -R -H C:\Recovery\OEM\Image\Install*.*
ATTRIB -S -R -H C:\Recovery\OEM\Image\AMD64\sources\*.*
ATTRIB -S -R -H C:\Recovery\OEM\Image\X86\sources\*.*
DEL /Q C:\Recovery\OEM\Image\Install*.*
DEL /Q C:\Recovery\OEM\Image\AMD64\sources\*.*
DEL /Q C:\Recovery\OEM\Image\X86\sources\*.*
PAUSE
EXIT 0

:MISSINGFILES
ECHO *****************************
ECHO Missing files
ECHO *****************************
ECHO Full image is not present
PAUSE
EXIT 1
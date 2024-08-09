@Echo Off
X:
CD \
CD RECOVERY
CLS

ECHO ****************************
ECHO Finding Assigned Letters
ECHO ****************************
SET BOOT=-1
SET DATA=-1
FOR /D %%I IN (C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO (
IF EXIST %%I:\Boot.Tag SET BOOT=%%I
IF EXIST %%I:\Recovery.Tag SET DATA=%%I
)
IF "%BOOT%"=="-1" GOTO ERROR
IF "%DATA%"=="-1" GOTO ERROR


ECHO *****************************
ECHO Copying Files
ECHO *****************************
MKDIR W:\Recovery\OEM\Image
MKDIR R:\Recovery\WindowsRE
MKDIR R:\Recovery\Logs
ROBOCOPY %DATA%:\Sources W:\Recovery\OEM\Image Install*.* /W:1 /R:2 /Z
IF %ERRORLEVEL% LSS 8 EXIT 0
GOTO ERROR



:ERROR
ECHO *****************************
ECHO Missing files / ERROR
ECHO *****************************
ECHO Scanstate files are missing
ECHO OR
ECHO ResetConfig.xml is missing
ECHO OR
ECHO ReCreatePartitions.txt is missing
ECHO OR
ECHO Syntax error in config file.
TIMEOUT 10
EXIT 1

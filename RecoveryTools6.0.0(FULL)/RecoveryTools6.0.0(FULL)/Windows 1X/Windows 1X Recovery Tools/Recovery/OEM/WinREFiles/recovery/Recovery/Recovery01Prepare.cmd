@Echo Off
X:
CD \
CD RECOVERY
CLS
IF "%1"=="" GOTO MISSINGDRIVE

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


ECHO *********************************
ECHO Finding WinRE/Windows partition #
ECHO *********************************
SET WINREPART=-1
SET WINPART=-1
TYPE %BOOT%:\sources\ResetConfig.xml | FIND "OSPartition" /I >X:\Find.txt
FOR /F "delims=<> tokens=3" %%I in (X:\Find.txt) DO SET WINPART=%%I
TYPE %BOOT%:\sources\ResetConfig.xml | FIND "WindowsREPartition" /I >X:\Find.txt
FOR /F "delims=<> tokens=3" %%I in (X:\Find.txt) DO SET WINREPART=%%I
If "%WINREPART%"=="-1" GOTO ERROR
If "%WINPART%"=="-1" GOTO ERROR


ECHO *********************************
ECHO Creating partition script
ECHO *********************************
ECHO SELECT DISK %1 >X:\Recovery.txt
ECHO CLEAN >>X:\Recovery.txt
TYPE %BOOT%:\sources\ReCreatePartitions.txt >>X:\Recovery.txt

ECHO SELECT DISK %1 >X:\Recovery2.txt
IF EXIST W:\ (
ECHO SELECT VOLUME W >>X:\Recovery2.txt
ECHO REMOVE >>X:\Recovery2.txt
)
IF EXIST R:\ (
ECHO SELECT VOLUME R >>X:\Recovery2.txt
ECHO REMOVE >>X:\Recovery2.txt
)
ECHO SELECT PARTITION %WINPART% >>X:\Recovery2.txt
ECHO ASSIGN LETTER W >>X:\Recovery2.txt
ECHO SELECT PARTITION %WINREPART% >>X:\Recovery2.txt
ECHO ASSIGN LETTER R >>X:\Recovery2.txt


ECHO *********************************
ECHO Preparing drive
ECHO *********************************
DISKPART /S X:\Recovery.txt
DISKPART /S X:\Recovery2.txt
IF NOT EXIST W:\ GOTO ERROR
IF NOT EXIST R:\ GOTO ERROR
EXIT 0


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

:MISSINGDRIVE
CLS
ECHO ***********************************
ECHO No destination specified
ECHO ***********************************
ECHO <Script name> DiskID
ECHO ***********************************
ECHO Example : Recovery01Prepare.cmd 2
ECHO ***********************************
TIMEOUT 5
EXIT 1
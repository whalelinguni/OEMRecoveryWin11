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
IF "%1"=="" GOTO MISSINGDRIVE

ECHO ****************************
ECHO Finding Free Letter
ECHO ****************************
SET BOOT=-1
FOR /D %%I IN (D E F G H I J K L M N O P Q R S T U V W X Y Z) DO (
IF NOT EXIST %%I:\ SET BOOT=%%I
)
SET DATA=-1
FOR /D %%I IN (D E F G H I J K L M N O P Q R S T U V W X Y Z) DO (
IF NOT EXIST %%I:\ IF "%%I" NEQ "%BOOT%" SET DATA=%%I
)
IF "%BOOT%"=="-1" GOTO NOFREELETTER
IF "%DATA%"=="-1" GOTO NOFREELETTER


:TRY1
ECHO ****************************
ECHO Partition creation / Format - Try #1
ECHO ****************************
IF NOT EXIST C:\Recovery\OEM\Temp MD C:\Recovery\OEM\Temp
ECHO SELECT DISK %1 >C:\Recovery\OEM\Temp\VolPrep1.txt
ECHO CLEAN>>C:\Recovery\OEM\Temp\VolPrep1.txt
ECHO CONVERT MBR>>C:\Recovery\OEM\Temp\VolPrep1.txt
ECHO SELECT DISK %1 >C:\Recovery\OEM\Temp\VolPrep2.txt
ECHO CREATE PARTITION PRIMARY SIZE=2048>>C:\Recovery\OEM\Temp\VolPrep2.txt
ECHO FORMAT FS=FAT32 QUICK LABEL=BOOT>>C:\Recovery\OEM\Temp\VolPrep2.txt
ECHO ACTIVE>>C:\Recovery\OEM\Temp\VolPrep2.txt
ECHO ASSIGN LETTER %BOOT%>>C:\Recovery\OEM\Temp\VolPrep2.txt
ECHO CREATE PARTITION PRIMARY>>C:\Recovery\OEM\Temp\VolPrep2.txt
ECHO FORMAT FS=NTFS QUICK LABEL=RECOVERY>>C:\Recovery\OEM\Temp\VolPrep2.txt
ECHO ASSIGN LETTER %DATA%>>C:\Recovery\OEM\Temp\VolPrep2.txt
DISKPART /S C:\Recovery\OEM\Temp\VolPrep1.txt
DISKPART /S C:\Recovery\OEM\Temp\VolPrep2.txt
RD /S /Q C:\Recovery\OEM\Temp


ECHO ****************************
ECHO Drive test - Try #1
ECHO ****************************
IF NOT EXIST %BOOT%:\ GOTO TRY2
IF NOT EXIST %DATA%:\ GOTO TRY2
GOTO END


:TRY2
ECHO ****************************
ECHO Partition creation / Format - Try #2
ECHO ****************************
IF NOT EXIST C:\Recovery\OEM\Temp MD C:\Recovery\OEM\Temp
ECHO SELECT DISK %1 >C:\Recovery\OEM\Temp\VolPrep1.txt
ECHO CLEAN>>C:\Recovery\OEM\Temp\VolPrep1.txt
ECHO CONVERT MBR>>C:\Recovery\OEM\Temp\VolPrep1.txt
ECHO SELECT DISK %1 >C:\Recovery\OEM\Temp\VolPrep2.txt
ECHO CREATE PARTITION PRIMARY SIZE=1024>>C:\Recovery\OEM\Temp\VolPrep2.txt
ECHO FORMAT FS=FAT32 QUICK LABEL=BOOT>>C:\Recovery\OEM\Temp\VolPrep2.txt
ECHO ACTIVE>>C:\Recovery\OEM\Temp\VolPrep2.txt
ECHO ASSIGN LETTER %BOOT%>>C:\Recovery\OEM\Temp\VolPrep2.txt
ECHO CREATE PARTITION PRIMARY>>C:\Recovery\OEM\Temp\VolPrep2.txt
ECHO FORMAT FS=NTFS QUICK LABEL=RECOVERY>>C:\Recovery\OEM\Temp\VolPrep2.txt
ECHO ASSIGN LETTER %DATA%>>C:\Recovery\OEM\Temp\VolPrep2.txt
DISKPART /S C:\Recovery\OEM\Temp\VolPrep1.txt
DISKPART /S C:\Recovery\OEM\Temp\VolPrep2.txt
RD /S /Q C:\Recovery\OEM\Temp


:END
ECHO ****************************
ECHO Drive test - Final
ECHO ****************************
IF NOT EXIST %BOOT%:\ EXIT 4
IF NOT EXIST %DATA%:\ EXIT 4
ECHO "Do Not Delete" >%BOOT%:\Boot.Tag
ECHO "Do Not Delete" >%DATA%:\Recovery.Tag
EXIT 0


:MISSINGDRIVE
IF EXIST %TEMP%\Recovery RD /S /Q %TEMP%\Recovery
IF EXIST %TEMP%\RecoveryMount RD /S /Q %TEMP%\RecoveryMount
CLS
ECHO ***********************************
ECHO No destination specified
ECHO ***********************************
ECHO <Script name> DiskID
ECHO ***********************************
ECHO Example : RecoveryDrive01Prepare.cmd 2
ECHO ***********************************
TIMEOUT 5
EXIT 1


:MISSINGIMAGE
IF EXIST %TEMP%\Recovery RD /S /Q %TEMP%\Recovery
IF EXIST %TEMP%\RecoveryMount RD /S /Q %TEMP%\RecoveryMount
CLS
ECHO ***********************************
ECHO No image exist
ECHO Cannot continue
ECHO ***********************************
TIMEOUT 5
EXIT 2


:NOFREELETTER
IF EXIST %TEMP%\Recovery RD /S /Q %TEMP%\Recovery
IF EXIST %TEMP%\RecoveryMount RD /S /Q %TEMP%\RecoveryMount
CLS
ECHO ***********************************
ECHO No free letters
ECHO Cannot continue
ECHO ***********************************
TIMEOUT 5
EXIT 3
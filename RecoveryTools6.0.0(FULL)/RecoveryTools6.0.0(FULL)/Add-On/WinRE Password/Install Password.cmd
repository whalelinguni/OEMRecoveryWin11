@Echo Off
%~d0%
CD "%~dp0%"

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

ECHO ************************************
ECHO Finding available drive letter
ECHO ************************************
SET LETTER=0
FOR /D %%L in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO (
IF NOT EXIST %%L:\ SET LETTER=%%L)
ECHO Letter to use : %LETTER%
IF %LETTER%==0 EXIT 1


ECHO ************************************
ECHO Deleting old files / Creating folder
ECHO ************************************
DEL %TEMP%\Winre.txt
DEL %TEMP%\Winre-Mount.txt
DEL %TEMP%\Winre-UnMount.txt
MD C:\Mount


ECHO ************************************
ECHO Finding Recovery Environment
ECHO ************************************
REAGENTC /info | find /i "Recovery" >%TEMP%\Winre.txt
FOR /F "delims=: tokens=2" %%I in (%TEMP%\Winre.txt) DO (FOR /F "delims=\ tokens=5" %%J in ("%%I") DO SET HDD=%%J)
FOR /F "delims=: tokens=2" %%I in (%TEMP%\Winre.txt) DO (FOR /F "delims=\ tokens=6" %%J in ("%%I") DO SET PARTITION=%%J)
FOR /F "delims=: tokens=2" %%I in (%TEMP%\Winre.txt) DO (FOR /F "delims=\ tokens=6*" %%J in ("%%I") DO SET REPATH=%%K)


ECHO ************************************
ECHO Result :
ECHO ************************************
SET PARTITION=%PARTITION:~-1%
SET HDD=%HDD:~-1%
ECHO Disk : %HDD%
ECHO Partition : %PARTITION%
ECHO Folder : %REPATH%


ECHO ************************************
ECHO Creating Diskpart script
ECHO ************************************
ECHO SELECT DISK %HDD% >%TEMP%\Winre-Mount.txt
ECHO SELECT PARTITION %PARTITION% >>%TEMP%\Winre-Mount.txt
ECHO ASSIGN LETTER %LETTER% >>%TEMP%\Winre-Mount.txt
ECHO SELECT VOLUME %LETTER% >%TEMP%\Winre-UnMount.txt
ECHO REMOVE >>%TEMP%\Winre-UnMount.txt


ECHO ************************************
ECHO Mounting Partition
ECHO ************************************
DISKPART /S %TEMP%\Winre-Mount.txt


ECHO ************************************
ECHO Mounting WINRE.WIM file
ECHO ************************************
IF EXIST "C:\%REPATH%\WinRE.Wim" SET LETTER=C
IF NOT EXIST %LETTER%:\%REPATH%\WinRE.Wim (
CLS
ECHO ************************************
ECHO ERROR!
ECHO ************************************
ECHO Recovery environment cannot be found!
PAUSE
DISKPART /S %TEMP%\Winre-UnMount.txt
GOTO END
)
DISM /Mount-Wim /WimFile:%LETTER%:\%REPATH%\WinRE.Wim /Index:1 /MountDir:C:\Mount


ECHO ************************************
ECHO Copying files
ECHO ************************************
ATTRIB -S -R -H C:\Mount\Windows\System32\winpeshl.ini
ATTRIB -S -R -H C:\Mount\Password\*.* /S
RD /S /Q C:\Mount\Password
IF NOT EXIST "C:\Mount\Windows\System32\winpeshl.SAV" COPY C:\Mount\Windows\System32\winpeshl.ini C:\Mount\Windows\System32\winpeshl.SAV
XCOPY .\WinREFiles\*.* C:\Mount\ /SEVHKY
COPY /Y C:\Mount\Windows\System32\winpeshl.%PROCESSOR_ARCHITECTURE%.INI C:\Mount\Windows\System32\winpeshl.ini
START /WAIT NOTEPAD.EXE C:\Mount\Password\Password.ini


ECHO ************************************
ECHO Unmounting WINRE.WIM file
ECHO ************************************
DISM /UnMount-Wim /MountDir:C:\Mount /Commit


ECHO ************************************
ECHO Unmounting partition
ECHO ************************************
DISKPART /S %TEMP%\Winre-UnMount.txt


:END
ECHO ************************************
ECHO Cleanup...
ECHO ************************************
DEL %TEMP%\Winre.txt
DEL %TEMP%\Winre-Mount.txt
DEL %TEMP%\Winre-UnMount.txt
RD C:\Mount

PAUSE
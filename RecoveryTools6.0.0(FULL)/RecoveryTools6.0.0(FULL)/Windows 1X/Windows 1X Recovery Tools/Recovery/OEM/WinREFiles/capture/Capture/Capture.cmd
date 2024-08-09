@Echo Off
X:
CD \
CD CAPTURE
CLS
ECHO *********************************
ECHO Mounting partitions
ECHO *********************************
DISKPART /S MOUNT.TXT

ECHO *********************************
ECHO Finding Windows
ECHO *********************************
SET DEST=-1
FOR /D %%I in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO @IF EXIST %%I:\Recovery\OEM\Find.Me SET DEST=%%I
IF "%DEST%"=="-1" GOTO MISSINGFILES

ECHO %DATE%-%TIME%-Deleting capture files >>%DEST%:\Recovery\OEM\Logs\Logfile.txt
ECHO *********************************
ECHO Deleting capture files
ECHO *********************************
ATTRIB -S -R -H %DEST%:\Recovery\OEM\Capture.wim
ATTRIB -S -R -H %DEST%:\Recovery\OEM\Boot.sdi
ATTRIB -S -R -H %DEST%:\Recovery\OEM\BCD.SAV
BCDEDIT /IMPORT %DEST%:\Recovery\OEM\BCD.SAV
DEL %DEST%:\Recovery\OEM\Capture.wim
DEL %DEST%:\Recovery\OEM\Boot.sdi
DEL %DEST%:\Recovery\OEM\BCD.SAV


ECHO %DATE%-%TIME%-Capturing Windows >>%DEST%:\Recovery\OEM\Logs\Logfile.txt
ECHO *********************************
ECHO Capturing Windows
ECHO *********************************
DISM.exe /Capture-Image /ImageFile:%DEST%:\Recovery\OEM\Image\install.wim /CaptureDir:%DEST%:\ /Name:"Windows 10"


ECHO %DATE%-%TIME%-Splitting Windows >>%DEST%:\Recovery\OEM\Logs\Logfile.txt
ECHO *********************************
ECHO Splitting image
ECHO *********************************
DISM.exe /Split-Image /ImageFile:%DEST%:\Recovery\OEM\Image\install.wim /SWMFile:%DEST%:\Recovery\OEM\Image\install.swm /FileSize:2048
IF EXIST %DEST%:\Recovery\OEM\Image\install.swm DEL %DEST%:\Recovery\OEM\Image\install.wim
IF EXIST %DEST%:\Recovery\OEM\Image\install.wim ECHO %DATE%-%TIME%-WIM image >>%DEST%:\Recovery\OEM\Logs\Logfile.txt
IF EXIST %DEST%:\Recovery\OEM\Image\install.swm ECHO %DATE%-%TIME%-SWM image >>%DEST%:\Recovery\OEM\Logs\Logfile.txt


ECHO %DATE%-%TIME%-Capture done >>%DEST%:\Recovery\OEM\Logs\Logfile.txt
ECHO *********************************
ECHO Shutting down
ECHO *********************************
PAUSE
WPEUTIL SHUTDOWN
EXIT 0

:MISSINGFILES
ECHO *****************************
ECHO Missing files
ECHO *****************************
ECHO Scanstate files are missing
ECHO OR
ECHO ResetConfig.xml is missing
ECHO OR
ECHO ReCreatePartitions.txt is missing
PAUSE
EXIT 1

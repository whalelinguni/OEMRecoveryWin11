@Echo Off
X:
CD \
CD RECOVERY
CLS


ECHO *****************************
ECHO Install Windows
ECHO *****************************
IF EXIST W:\Recovery\OEM\Image\Install.wim @DISM /Apply-Image /Index:1 /ImageFile:W:\Recovery\OEM\Image\Install.wim /ApplyDir:W:\
IF EXIST W:\Recovery\OEM\Image\Install.swm @DISM /Apply-Image /Index:1 /ImageFile:W:\Recovery\OEM\Image\Install.swm /ApplyDir:W:\ /SWMFile:W:\Recovery\OEM\Image\Install*.swm
IF NOT EXIST W:\Windows\Explorer.exe EXIT 1
ATTRIB -S -R -H W:\Recovery\*.* /S
XCOPY W:\Recovery\OEM\Image\%PROCESSOR_ARCHITECTURE%\sources\boot.wim R:\Recovery\WindowsRE\
REN R:\Recovery\WindowsRE\Boot.Wim WinRE.Wim
ATTRIB -S -R -H W:\Recovery\OEM\*.*
DEL W:\Recovery\OEM\BCD*.*


ECHO *****************************
ECHO Boot loader
ECHO *****************************
BCDBOOT W:\Windows
W:\Windows\System32\REAGENTC /SetReImage /Path R:\Recovery\WindowsRE\WinRE.wim /logpath R:\Recovery\Logs /target W:\Windows


ECHO *****************************
ECHO Fixing ACLS
ECHO *****************************
ATTRIB -S -R -H W:\Recovery
ATTRIB -S -R -H W:\Recovery /S
icacls W:\Recovery /reset /T /C
icacls W:\Recovery /inheritance:r /grant:r SYSTEM:(OI)(CI)(F) /grant:r *S-1-5-32-544:(OI)(CI)(F) /grant:r *S-1-5-32-545:(OI)(CI)(RX) /C
ATTRIB +S +H W:\Recovery
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

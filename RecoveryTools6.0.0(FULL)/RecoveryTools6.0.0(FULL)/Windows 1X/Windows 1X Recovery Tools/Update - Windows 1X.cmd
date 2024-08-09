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

ECHO %DATE%-%TIME%-Tools Update-Start >>C:\Recovery\OEM\Logs\Logfile.txt
ECHO *************************************
ECHO Merging previous image. Please wait ...
ECHO *************************************
IF EXIST C:\Recovery\OEM\Image\Install.swm (
DISM.exe /Export-Image /SourceImageFile:C:\Recovery\OEM\Image\Install.swm /SourceIndex:1 /DestinationImageFile:C:\Recovery\OEM\Image\Install.wim /SWMFile:C:\Recovery\OEM\Image\Install*.swm
IF EXIST C:\Recovery\OEM\Image\Install.wim DEL C:\Recovery\OEM\Image\Install*.swm
)


ECHO *************************************
ECHO Mounting image if it exist. Please wait ...
ECHO *************************************
IF EXIST C:\Recovery\OEM\Image\Install.wim (
MKDIR C:\RecoveryTemp
DISM /Mount-Wim /WimFile:C:\Recovery\OEM\Image\Install.wim /Index:1 /MountDir:C:\RecoveryTemp
)


ECHO *************************************
ECHO Removing previous files. Please wait ...
ECHO *************************************
RD /S /Q C:\Recovery\OEM\Menu
RD /S /Q C:\Recovery\OEM\Tools
RD /S /Q C:\Recovery\OEM\WinREFiles
RD /S /Q C:\Recovery\OEM\XML
RD /S /Q C:\Recovery\OEM\ScanState
RD /S /Q C:\Recovery\OEM\Settings
RD /S /Q C:\Recovery\OEM\RootCert
RD /S /Q C:\Recovery\OEM\AutoIT
DEL /F C:\Recovery\Customizations\Config_AppsAndSettings.xml
DEL /F C:\Recovery\Customizations\Config_AppsOnly.xml
DEL /F C:\Recovery\Customizations\Config_SettingsOnly.xml
DEL /F C:\Recovery\OEM\Sysprep.cmd
DEL /F C:\Recovery\OEM\Scripts\AppsUpdate.cmd
DEL /F C:\Recovery\OEM\Scripts\BootToWinRe.cmd
DEL /F C:\Recovery\OEM\Scripts\FixACLS.cmd
DEL /F C:\Recovery\OEM\Scripts\OOBE.cmd
DEL /F C:\Recovery\OEM\Scripts\EnableSystemRestore.ps1
DEL /F C:\Recovery\OEM\Scripts\Restore.cmd
DEL /F C:\Recovery\OEM\Scripts\WinREUpdate.cmd
DEL /F C:\Recovery\OEM\Scripts\RecoveryDrive01Prepare.cmd
DEL /F C:\Recovery\OEM\Scripts\RecoveryDrive02CopyTools.cmd
DEL /F C:\Recovery\OEM\Scripts\RecoveryDrive03CopyImage.cmd
DEL /F C:\Recovery\OEM\Scripts\DeleteImage.cmd
DEL /F C:\Recovery\OEM\Scripts\Lock.cmd
DEL /F C:\Recovery\OEM\Image\amd64\bootmgr
DEL /F C:\Recovery\OEM\Image\amd64\bootmgr.efi
DEL /F C:\Recovery\OEM\Image\amd64\boot\bcd
DEL /F C:\Recovery\OEM\Image\amd64\boot\boot.sdi
DEL /F C:\Recovery\OEM\Image\amd64\boot\bootfix.bin
DEL /F C:\Recovery\OEM\Image\amd64\boot\bootsect.exe
DEL /F C:\Recovery\OEM\Image\amd64\boot\etfsboot.com
DEL /F C:\Recovery\OEM\Image\amd64\boot\memtest.exe
DEL /F C:\Recovery\OEM\Image\amd64\boot\en-us\bootsect.exe.mui
DEL /F C:\Recovery\OEM\Image\amd64\boot\fonts\chs_boot.ttf
DEL /F C:\Recovery\OEM\Image\amd64\boot\fonts\cht_boot.ttf
DEL /F C:\Recovery\OEM\Image\amd64\boot\fonts\jpn_boot.ttf
DEL /F C:\Recovery\OEM\Image\amd64\boot\fonts\kor_boot.ttf
DEL /F C:\Recovery\OEM\Image\amd64\boot\fonts\malgunn_boot.ttf
DEL /F C:\Recovery\OEM\Image\amd64\boot\fonts\malgun_boot.ttf
DEL /F C:\Recovery\OEM\Image\amd64\boot\fonts\malgun_console.ttf
DEL /F C:\Recovery\OEM\Image\amd64\boot\fonts\meiryon_boot.ttf
DEL /F C:\Recovery\OEM\Image\amd64\boot\fonts\meiryo_boot.ttf
DEL /F C:\Recovery\OEM\Image\amd64\boot\fonts\meiryo_console.ttf
DEL /F C:\Recovery\OEM\Image\amd64\boot\fonts\msjhn_boot.ttf
DEL /F C:\Recovery\OEM\Image\amd64\boot\fonts\msjh_boot.ttf
DEL /F C:\Recovery\OEM\Image\amd64\boot\fonts\msjh_console.ttf
DEL /F C:\Recovery\OEM\Image\amd64\boot\fonts\msyhn_boot.ttf
DEL /F C:\Recovery\OEM\Image\amd64\boot\fonts\msyh_boot.ttf
DEL /F C:\Recovery\OEM\Image\amd64\boot\fonts\msyh_console.ttf
DEL /F C:\Recovery\OEM\Image\amd64\boot\fonts\segmono_boot.ttf
DEL /F C:\Recovery\OEM\Image\amd64\boot\fonts\segoen_slboot.ttf
DEL /F C:\Recovery\OEM\Image\amd64\boot\fonts\segoe_slboot.ttf
DEL /F C:\Recovery\OEM\Image\amd64\boot\fonts\wgl4_boot.ttf
DEL /F C:\Recovery\OEM\Image\amd64\boot\resources\bootres.dll
DEL /F C:\Recovery\OEM\Image\amd64\efi\boot\bootx64.efi
DEL /F C:\Recovery\OEM\Image\amd64\efi\microsoft\boot\bcd
DEL /F C:\Recovery\OEM\Image\amd64\efi\microsoft\boot\cdboot.efi
DEL /F C:\Recovery\OEM\Image\amd64\efi\microsoft\boot\cdboot_noprompt.efi
DEL /F C:\Recovery\OEM\Image\amd64\efi\microsoft\boot\efisys.bin
DEL /F C:\Recovery\OEM\Image\amd64\efi\microsoft\boot\efisys_noprompt.bin
DEL /F C:\Recovery\OEM\Image\amd64\efi\microsoft\boot\memtest.efi
DEL /F C:\Recovery\OEM\Image\amd64\efi\microsoft\boot\winsipolicy.p7b
DEL /F C:\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\chs_boot.ttf
DEL /F C:\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\cht_boot.ttf
DEL /F C:\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\jpn_boot.ttf
DEL /F C:\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\kor_boot.ttf
DEL /F C:\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\malgunn_boot.ttf
DEL /F C:\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\malgun_boot.ttf
DEL /F C:\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\malgun_console.ttf
DEL /F C:\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\meiryon_boot.ttf
DEL /F C:\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\meiryo_boot.ttf
DEL /F C:\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\meiryo_console.ttf
DEL /F C:\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\msjhn_boot.ttf
DEL /F C:\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\msjh_boot.ttf
DEL /F C:\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\msjh_console.ttf
DEL /F C:\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\msyhn_boot.ttf
DEL /F C:\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\msyh_boot.ttf
DEL /F C:\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\msyh_console.ttf
DEL /F C:\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\segmono_boot.ttf
DEL /F C:\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\segoen_slboot.ttf
DEL /F C:\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\segoe_slboot.ttf
DEL /F C:\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\wgl4_boot.ttf
DEL /F C:\Recovery\OEM\Image\amd64\efi\microsoft\boot\resources\bootres.dll
DEL /F C:\Recovery\OEM\Image\x86\bootmgr
DEL /F C:\Recovery\OEM\Image\x86\bootmgr.efi
DEL /F C:\Recovery\OEM\Image\x86\boot\bcd
DEL /F C:\Recovery\OEM\Image\x86\boot\boot.sdi
DEL /F C:\Recovery\OEM\Image\x86\boot\bootfix.bin
DEL /F C:\Recovery\OEM\Image\x86\boot\bootsect.exe
DEL /F C:\Recovery\OEM\Image\x86\boot\etfsboot.com
DEL /F C:\Recovery\OEM\Image\x86\boot\memtest.exe
DEL /F C:\Recovery\OEM\Image\x86\boot\en-us\bootsect.exe.mui
DEL /F C:\Recovery\OEM\Image\x86\boot\fonts\chs_boot.ttf
DEL /F C:\Recovery\OEM\Image\x86\boot\fonts\cht_boot.ttf
DEL /F C:\Recovery\OEM\Image\x86\boot\fonts\jpn_boot.ttf
DEL /F C:\Recovery\OEM\Image\x86\boot\fonts\kor_boot.ttf
DEL /F C:\Recovery\OEM\Image\x86\boot\fonts\malgunn_boot.ttf
DEL /F C:\Recovery\OEM\Image\x86\boot\fonts\malgun_boot.ttf
DEL /F C:\Recovery\OEM\Image\x86\boot\fonts\malgun_console.ttf
DEL /F C:\Recovery\OEM\Image\x86\boot\fonts\meiryon_boot.ttf
DEL /F C:\Recovery\OEM\Image\x86\boot\fonts\meiryo_boot.ttf
DEL /F C:\Recovery\OEM\Image\x86\boot\fonts\meiryo_console.ttf
DEL /F C:\Recovery\OEM\Image\x86\boot\fonts\msjhn_boot.ttf
DEL /F C:\Recovery\OEM\Image\x86\boot\fonts\msjh_boot.ttf
DEL /F C:\Recovery\OEM\Image\x86\boot\fonts\msjh_console.ttf
DEL /F C:\Recovery\OEM\Image\x86\boot\fonts\msyhn_boot.ttf
DEL /F C:\Recovery\OEM\Image\x86\boot\fonts\msyh_boot.ttf
DEL /F C:\Recovery\OEM\Image\x86\boot\fonts\msyh_console.ttf
DEL /F C:\Recovery\OEM\Image\x86\boot\fonts\segmono_boot.ttf
DEL /F C:\Recovery\OEM\Image\x86\boot\fonts\segoen_slboot.ttf
DEL /F C:\Recovery\OEM\Image\x86\boot\fonts\segoe_slboot.ttf
DEL /F C:\Recovery\OEM\Image\x86\boot\fonts\wgl4_boot.ttf
DEL /F C:\Recovery\OEM\Image\x86\boot\resources\bootres.dll
DEL /F C:\Recovery\OEM\Image\x86\efi\boot\bootia32.efi
DEL /F C:\Recovery\OEM\Image\x86\efi\microsoft\boot\bcd
DEL /F C:\Recovery\OEM\Image\x86\efi\microsoft\boot\cdboot.efi
DEL /F C:\Recovery\OEM\Image\x86\efi\microsoft\boot\cdboot_noprompt.efi
DEL /F C:\Recovery\OEM\Image\x86\efi\microsoft\boot\efisys.bin
DEL /F C:\Recovery\OEM\Image\x86\efi\microsoft\boot\efisys_noprompt.bin
DEL /F C:\Recovery\OEM\Image\x86\efi\microsoft\boot\memtest.efi
DEL /F C:\Recovery\OEM\Image\x86\efi\microsoft\boot\winsipolicy.p7b
DEL /F C:\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\chs_boot.ttf
DEL /F C:\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\cht_boot.ttf
DEL /F C:\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\jpn_boot.ttf
DEL /F C:\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\kor_boot.ttf
DEL /F C:\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\malgunn_boot.ttf
DEL /F C:\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\malgun_boot.ttf
DEL /F C:\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\malgun_console.ttf
DEL /F C:\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\meiryon_boot.ttf
DEL /F C:\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\meiryo_boot.ttf
DEL /F C:\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\meiryo_console.ttf
DEL /F C:\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\msjhn_boot.ttf
DEL /F C:\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\msjh_boot.ttf
DEL /F C:\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\msjh_console.ttf
DEL /F C:\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\msyhn_boot.ttf
DEL /F C:\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\msyh_boot.ttf
DEL /F C:\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\msyh_console.ttf
DEL /F C:\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\segmono_boot.ttf
DEL /F C:\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\segoen_slboot.ttf
DEL /F C:\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\segoe_slboot.ttf
DEL /F C:\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\wgl4_boot.ttf
DEL /F C:\Recovery\OEM\Image\x86\efi\microsoft\boot\resources\bootres.dll


IF EXIST C:\RecoveryTemp\Recovery\OEM (
RD /S /Q C:\RecoveryTemp\Recovery\OEM\Menu
RD /S /Q C:\RecoveryTemp\Recovery\OEM\Tools
RD /S /Q C:\RecoveryTemp\Recovery\OEM\WinREFiles
RD /S /Q C:\RecoveryTemp\Recovery\OEM\XML
RD /S /Q C:\RecoveryTemp\Recovery\OEM\ScanState
RD /S /Q C:\RecoveryTemp\Recovery\OEM\Settings
RD /S /Q C:\RecoveryTemp\Recovery\OEM\RootCert
RD /S /Q C:\RecoveryTemp\Recovery\OEM\AutoIT
DEL /F C:\RecoveryTemp\Recovery\Customizations\Config_AppsAndSettings.xml
DEL /F C:\RecoveryTemp\Recovery\Customizations\Config_AppsOnly.xml
DEL /F C:\RecoveryTemp\Recovery\Customizations\Config_SettingsOnly.xml
DEL /F C:\RecoveryTemp\Recovery\OEM\Sysprep.cmd
DEL /F C:\RecoveryTemp\Recovery\OEM\Scripts\AppsUpdate.cmd
DEL /F C:\RecoveryTemp\Recovery\OEM\Scripts\BootToWinRe.cmd
DEL /F C:\RecoveryTemp\Recovery\OEM\Scripts\FixACLS.cmd
DEL /F C:\RecoveryTemp\Recovery\OEM\Scripts\OOBE.cmd
DEL /F C:\RecoveryTemp\Recovery\OEM\Scripts\EnableSystemRestore.ps1
DEL /F C:\RecoveryTemp\Recovery\OEM\Scripts\Restore.cmd
DEL /F C:\RecoveryTemp\Recovery\OEM\Scripts\WinREUpdate.cmd
DEL /F C:\RecoveryTemp\Recovery\OEM\Scripts\RecoveryDrive01Prepare.cmd
DEL /F C:\RecoveryTemp\Recovery\OEM\Scripts\RecoveryDrive02CopyTools.cmd
DEL /F C:\RecoveryTemp\Recovery\OEM\Scripts\RecoveryDrive03CopyImage.cmd
DEL /F C:\RecoveryTemp\Recovery\OEM\Scripts\DeleteImage.cmd
DEL /F C:\RecoveryTemp\Recovery\OEM\Scripts\Lock.cmd
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\bootmgr
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\bootmgr.efi
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\boot\bcd
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\boot\boot.sdi
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\boot\bootfix.bin
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\boot\bootsect.exe
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\boot\etfsboot.com
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\boot\memtest.exe
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\boot\en-us\bootsect.exe.mui
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\boot\fonts\chs_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\boot\fonts\cht_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\boot\fonts\jpn_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\boot\fonts\kor_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\boot\fonts\malgunn_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\boot\fonts\malgun_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\boot\fonts\malgun_console.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\boot\fonts\meiryon_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\boot\fonts\meiryo_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\boot\fonts\meiryo_console.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\boot\fonts\msjhn_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\boot\fonts\msjh_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\boot\fonts\msjh_console.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\boot\fonts\msyhn_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\boot\fonts\msyh_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\boot\fonts\msyh_console.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\boot\fonts\segmono_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\boot\fonts\segoen_slboot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\boot\fonts\segoe_slboot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\boot\fonts\wgl4_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\boot\resources\bootres.dll
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\efi\boot\bootx64.efi
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\efi\microsoft\boot\bcd
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\efi\microsoft\boot\cdboot.efi
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\efi\microsoft\boot\cdboot_noprompt.efi
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\efi\microsoft\boot\efisys.bin
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\efi\microsoft\boot\efisys_noprompt.bin
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\efi\microsoft\boot\memtest.efi
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\efi\microsoft\boot\winsipolicy.p7b
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\chs_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\cht_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\jpn_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\kor_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\malgunn_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\malgun_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\malgun_console.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\meiryon_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\meiryo_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\meiryo_console.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\msjhn_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\msjh_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\msjh_console.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\msyhn_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\msyh_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\msyh_console.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\segmono_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\segoen_slboot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\segoe_slboot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\efi\microsoft\boot\fonts\wgl4_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\amd64\efi\microsoft\boot\resources\bootres.dll
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\bootmgr
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\bootmgr.efi
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\boot\bcd
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\boot\boot.sdi
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\boot\bootfix.bin
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\boot\bootsect.exe
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\boot\etfsboot.com
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\boot\memtest.exe
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\boot\en-us\bootsect.exe.mui
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\boot\fonts\chs_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\boot\fonts\cht_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\boot\fonts\jpn_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\boot\fonts\kor_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\boot\fonts\malgunn_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\boot\fonts\malgun_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\boot\fonts\malgun_console.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\boot\fonts\meiryon_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\boot\fonts\meiryo_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\boot\fonts\meiryo_console.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\boot\fonts\msjhn_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\boot\fonts\msjh_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\boot\fonts\msjh_console.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\boot\fonts\msyhn_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\boot\fonts\msyh_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\boot\fonts\msyh_console.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\boot\fonts\segmono_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\boot\fonts\segoen_slboot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\boot\fonts\segoe_slboot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\boot\fonts\wgl4_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\boot\resources\bootres.dll
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\efi\boot\bootia32.efi
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\efi\microsoft\boot\bcd
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\efi\microsoft\boot\cdboot.efi
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\efi\microsoft\boot\cdboot_noprompt.efi
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\efi\microsoft\boot\efisys.bin
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\efi\microsoft\boot\efisys_noprompt.bin
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\efi\microsoft\boot\memtest.efi
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\efi\microsoft\boot\winsipolicy.p7b
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\chs_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\cht_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\jpn_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\kor_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\malgunn_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\malgun_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\malgun_console.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\meiryon_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\meiryo_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\meiryo_console.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\msjhn_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\msjh_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\msjh_console.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\msyhn_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\msyh_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\msyh_console.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\segmono_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\segoen_slboot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\segoe_slboot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\efi\microsoft\boot\fonts\wgl4_boot.ttf
DEL /F C:\RecoveryTemp\Recovery\OEM\Image\x86\efi\microsoft\boot\resources\bootres.dll
)


ECHO *************************************
ECHO Copying new files. Please wait ...
ECHO *************************************
MD C:\Recovery\OEM\Image
MD C:\Recovery\OEM\Menu
MD C:\Recovery\OEM\WinREFiles
MD C:\Recovery\OEM\XML
MD C:\Recovery\OEM\Settings
MD C:\Recovery\OEM\Image
MD C:\Recovery\OEM\AutoIt
XCOPY "%CD%\Recovery\OEM\Image\*.*" "C:\Recovery\OEM\Image\" /SEVH
XCOPY "%CD%\Recovery\OEM\Menu\*.*" "C:\Recovery\OEM\Menu\" /SEVH
XCOPY "%CD%\Recovery\OEM\WinREFiles\*.*" "C:\Recovery\OEM\WinREFiles\" /SEVH
XCOPY "%CD%\Recovery\OEM\XML\*.*" "C:\Recovery\OEM\XML\" /SEVH
XCOPY "%CD%\Recovery\OEM\Settings\*.*" "C:\Recovery\OEM\Settings\" /SEVH
XCOPY "%CD%\Recovery\OEM\AutoIt\*.*" "C:\Recovery\OEM\AutoIT\" /SEVH
COPY "%CD%\Recovery\OEM\Sysprep.cmd" "C:\Recovery\OEM\Sysprep.cmd"
COPY "%CD%\Recovery\OEM\Scripts\BootToWinRe.cmd" "C:\Recovery\OEM\Scripts\BootToWinRe.cmd"
COPY "%CD%\Recovery\OEM\Scripts\FixACLS.cmd" "C:\Recovery\OEM\Scripts\FixACLS.cmd"
COPY "%CD%\Recovery\OEM\Scripts\OOBE.cmd" "C:\Recovery\OEM\Scripts\OOBE.cmd"
COPY "%CD%\Recovery\OEM\Scripts\EnableSystemRestore.ps1" "C:\Recovery\OEM\Scripts\EnableSystemRestore.ps1"
COPY "%CD%\Recovery\OEM\Scripts\Restore.cmd" "C:\Recovery\OEM\Scripts\Restore.cmd"
COPY "%CD%\Recovery\OEM\Scripts\WinREUpdate.cmd" "C:\Recovery\OEM\Scripts\WinREUpdate.cmd"
COPY "%CD%\Recovery\OEM\Scripts\RecoveryDrive01Prepare.cmd" "C:\Recovery\OEM\Scripts\RecoveryDrive01Prepare.cmd"
COPY "%CD%\Recovery\OEM\Scripts\RecoveryDrive02CopyTools.cmd" "C:\Recovery\OEM\Scripts\RecoveryDrive02CopyTools.cmd"
COPY "%CD%\Recovery\OEM\Scripts\RecoveryDrive03CopyImage.cmd" "C:\Recovery\OEM\Scripts\RecoveryDrive03CopyImage.cmd"
COPY "%CD%\Recovery\OEM\Scripts\DeleteImage.cmd" "C:\Recovery\OEM\Scripts\DeleteImage.cmd"


IF EXIST C:\RecoveryTemp\Recovery\OEM (
MD C:\RecoveryTemp\Recovery\OEM\Image
MD C:\RecoveryTemp\Recovery\OEM\Menu
MD C:\RecoveryTemp\Recovery\OEM\WinREFiles
MD C:\RecoveryTemp\Recovery\OEM\XML
MD C:\RecoveryTemp\Recovery\OEM\Settings
MD C:\RecoveryTemp\Recovery\OEM\Image
MD C:\RecoveryTemp\Recovery\OEM\AutoIt
XCOPY "%CD%\Recovery\OEM\Image\*.*" "C:\RecoveryTemp\Recovery\OEM\Image\" /SEVH
XCOPY "%CD%\Recovery\OEM\Menu\*.*" "C:\RecoveryTemp\Recovery\OEM\Menu\" /SEVH
XCOPY "%CD%\Recovery\OEM\WinREFiles\*.*" "C:\RecoveryTemp\Recovery\OEM\WinREFiles\" /SEVH
XCOPY "%CD%\Recovery\OEM\XML\*.*" "C:\RecoveryTemp\Recovery\OEM\XML\" /SEVH
XCOPY "%CD%\Recovery\OEM\Settings\*.*" "C:\RecoveryTemp\Recovery\OEM\Settings\" /SEVH
XCOPY "%CD%\Recovery\OEM\AutoIt\*.*" "C:\RecoveryTemp\Recovery\OEM\AutoIT\" /SEVH
COPY "%CD%\Recovery\OEM\Sysprep.cmd" "C:\RecoveryTemp\Recovery\OEM\Sysprep.cmd"
COPY "%CD%\Recovery\OEM\Scripts\BootToWinRe.cmd" "C:\RecoveryTemp\Recovery\OEM\Scripts\BootToWinRe.cmd"
COPY "%CD%\Recovery\OEM\Scripts\FixACLS.cmd" "C:\RecoveryTemp\Recovery\OEM\Scripts\FixACLS.cmd"
COPY "%CD%\Recovery\OEM\Scripts\OOBE.cmd" "C:\RecoveryTemp\Recovery\OEM\Scripts\OOBE.cmd"
COPY "%CD%\Recovery\OEM\Scripts\EnableSystemRestore.ps1" "C:\RecoveryTemp\Recovery\OEM\Scripts\EnableSystemRestore.ps1"
COPY "%CD%\Recovery\OEM\Scripts\Restore.cmd" "C:\RecoveryTemp\Recovery\OEM\Scripts\Restore.cmd"
COPY "%CD%\Recovery\OEM\Scripts\WinREUpdate.cmd" "C:\RecoveryTemp\Recovery\OEM\Scripts\WinREUpdate.cmd"
COPY "%CD%\Recovery\OEM\Scripts\RecoveryDrive01Prepare.cmd" "C:\RecoveryTemp\Recovery\OEM\Scripts\RecoveryDrive01Prepare.cmd"
COPY "%CD%\Recovery\OEM\Scripts\RecoveryDrive02CopyTools.cmd" "C:\RecoveryTemp\Recovery\OEM\Scripts\RecoveryDrive02CopyTools.cmd"
COPY "%CD%\Recovery\OEM\Scripts\RecoveryDrive03CopyImage.cmd" "C:\RecoveryTemp\Recovery\OEM\Scripts\RecoveryDrive03CopyImage.cmd"
COPY "%CD%\Recovery\OEM\Scripts\DeleteImage.cmd" "C:\RecoveryTemp\Recovery\OEM\Scripts\DeleteImage.cmd"
)


ECHO *************************************
ECHO UnMounting image if it exist. Please wait ...
ECHO *************************************
IF EXIST C:\Recovery\OEM\Image\Install.wim (
ECHO %DATE%-%TIME%-Tools Update-End >>C:\RecoveryTemp\Recovery\OEM\Logs\Logfile.txt
DISM /UnMount-Wim /MountDir:C:\RecoveryTemp /Commit
RD C:\RecoveryTemp


ECHO *********************************
ECHO Splitting image
ECHO *********************************
DISM.exe /Split-Image /ImageFile:C:\Recovery\OEM\Image\install.wim /SWMFile:C:\Recovery\OEM\Image\install.swm /FileSize:2048
IF EXIST C:\Recovery\OEM\Image\install.swm DEL C:\Recovery\OEM\Image\install.wim
)


ECHO *********************************
ECHO Creating Icons
ECHO *********************************
START /WAIT "Creating Icons" "C:\Recovery\OEM\AutoIt\AutoIt3_%PROCESSOR_ARCHITECTURE%.EXE" "C:\Recovery\OEM\Menu\CreateShortcut.au3" "C:\Recovery\OEM\AutoIt\AutoIt3_%PROCESSOR_ARCHITECTURE%.EXE" "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Recovery Tools.lnk" "C:\Recovery\OEM\Menu" "C:\Recovery\OEM\Menu\Recovery.au3" "Computer Recovery Tools" "C:\Recovery\OEM\Menu\appicon.ico"
START /WAIT "Creating Icons" "C:\Recovery\OEM\AutoIt\AutoIt3_%PROCESSOR_ARCHITECTURE%.EXE" "C:\Recovery\OEM\Menu\CreateShortcut.au3" "C:\Recovery\OEM\AutoIt\AutoIt3_%PROCESSOR_ARCHITECTURE%.EXE" "C:\Users\Public\Desktop\Recovery Tools.lnk" "C:\Recovery\OEM\Menu" "C:\Recovery\OEM\Menu\Recovery.au3" "Computer Recovery Tools" "C:\Recovery\OEM\Menu\appicon.ico"


ECHO *************************************
ECHO Updating WinRE. Please wait ...
ECHO *************************************
START /WAIT "WinRE Update" "C:\recovery\OEM\Scripts\WinREUpdate.cmd"


ECHO *************************************
ECHO Update done
ECHO *************************************
ECHO Please create a new recovery media to keep the new version in case of recovery.
ECHO *************************************
ECHO %DATE%-%TIME%-Tools Update-End >>C:\Recovery\OEM\Logs\Logfile.txt
PAUSE
EXIT 0

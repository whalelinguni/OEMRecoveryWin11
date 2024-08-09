@Echo OFF

ECHO ******************************************
ECHO Updating WinRE Password
ECHO ******************************************
RD /S /Q "..\Add-On\WinRE Password\WinREFiles\AutoIt"
MD "..\Add-On\WinRE Password\WinREFiles\AutoIt\Include"
COPY ".\AutoIt\Include\*.*" "..\Add-On\WinRE Password\WinREFiles\AutoIt\Include"
COPY ".\AutoIt\AutoIt3.exe" "..\Add-On\WinRE Password\WinREFiles\AutoIt\AutoIt3_x86.exe"
COPY ".\AutoIt\AutoIt3_x64.exe" "..\Add-On\WinRE Password\WinREFiles\AutoIt\AutoIt3_amd64.exe"
COPY /Y ".\WinRE Password\Password.au3" "..\Add-On\WinRE Password\WinREFiles\Password"


ECHO ******************************************
ECHO Updating Windows 1X
ECHO ******************************************
RD /S /Q "..\Windows 1X\Windows 1X Recovery Tools\Recovery\OEM\AutoIt"
RD /S /Q "..\Windows 1X\Windows 1X Recovery Tools\Recovery\OEM\WinREFiles\recovery\AutoIt"
RD /S /Q "..\Windows 1X\Windows 1X Recovery Tools\Recovery\OEM\WinREFiles\amd64\sources\recovery\tools\AutoIt"
RD /S /Q "..\Windows 1X\Windows 1X Recovery Tools\Recovery\OEM\WinREFiles\x86\sources\recovery\tools\AutoIt"
MD "..\Windows 1X\Windows 1X Recovery Tools\Recovery\OEM\AutoIt\Include"
MD "..\Windows 1X\Windows 1X Recovery Tools\Recovery\OEM\WinREFiles\recovery\AutoIt\Include"
MD "..\Windows 1X\Windows 1X Recovery Tools\Recovery\OEM\WinREFiles\amd64\sources\recovery\tools\AutoIt\Include"
MD "..\Windows 1X\Windows 1X Recovery Tools\Recovery\OEM\WinREFiles\x86\sources\recovery\tools\AutoIt\Include"
COPY ".\AutoIt\Include\*.*" "..\Windows 1X\Windows 1X Recovery Tools\Recovery\OEM\AutoIt\Include"
COPY ".\AutoIt\AutoIt3.exe" "..\Windows 1X\Windows 1X Recovery Tools\Recovery\OEM\AutoIt\AutoIt3_x86.exe"
COPY ".\AutoIt\AutoIt3_x64.exe" "..\Windows 1X\Windows 1X Recovery Tools\Recovery\OEM\AutoIt\AutoIt3_amd64.exe"
COPY ".\AutoIt\Include\*.*" "..\Windows 1X\Windows 1X Recovery Tools\Recovery\OEM\WinREFiles\recovery\AutoIt\Include"
COPY ".\AutoIt\AutoIt3.exe" "..\Windows 1X\Windows 1X Recovery Tools\Recovery\OEM\WinREFiles\recovery\AutoIt\AutoIt3_x86.exe"
COPY ".\AutoIt\AutoIt3_x64.exe" "..\Windows 1X\Windows 1X Recovery Tools\Recovery\OEM\WinREFiles\recovery\AutoIt\AutoIt3_amd64.exe"
COPY ".\AutoIt\Include\*.*" "..\Windows 1X\Windows 1X Recovery Tools\Recovery\OEM\WinREFiles\amd64\sources\recovery\tools\AutoIt\Include"
COPY ".\AutoIt\AutoIt3.exe" "..\Windows 1X\Windows 1X Recovery Tools\Recovery\OEM\WinREFiles\amd64\sources\recovery\tools\AutoIt\AutoIt3_x86.exe"
COPY ".\AutoIt\AutoIt3_x64.exe" "..\Windows 1X\Windows 1X Recovery Tools\Recovery\OEM\WinREFiles\amd64\sources\recovery\tools\AutoIt\AutoIt3_amd64.exe"
COPY ".\AutoIt\Include\*.*" "..\Windows 1X\Windows 1X Recovery Tools\Recovery\OEM\WinREFiles\x86\sources\recovery\tools\AutoIt\Include"
COPY ".\AutoIt\AutoIt3.exe" "..\Windows 1X\Windows 1X Recovery Tools\Recovery\OEM\WinREFiles\x86\sources\recovery\tools\AutoIt\AutoIt3_x86.exe"
COPY ".\AutoIt\AutoIt3_x64.exe" "..\Windows 1X\Windows 1X Recovery Tools\Recovery\OEM\WinREFiles\x86\sources\recovery\tools\AutoIt\AutoIt3_amd64.exe"
COPY /Y ".\Prevent Sleep\PreventSleep.au3" "..\Windows 1X\Windows 1X Recovery Tools\Recovery\OEM"
COPY /Y ".\Windows 1X\CreateShortcut.au3" "..\Windows 1X\Windows 1X Recovery Tools\Recovery\OEM\Menu"
COPY /Y ".\Windows 1X\Recovery.au3" "..\Windows 1X\Windows 1X Recovery Tools\Recovery\OEM\Menu"
COPY /Y ".\Windows 1X\RecoveryUSB.au3" "..\Windows 1X\Windows 1X Recovery Tools\Recovery\OEM\WinREFiles\recovery\Recovery"
COPY /Y ".\Windows 1X\Menu.au3" "..\Windows 1X\Windows 1X Recovery Tools\Recovery\OEM\WinREFiles\amd64\sources\recovery\tools"
COPY /Y ".\Windows 1X\Menu.au3" "..\Windows 1X\Windows 1X Recovery Tools\Recovery\OEM\WinREFiles\x86\sources\recovery\tools"

PAUSE

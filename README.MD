# https://www.anarethos.com/recovery_tools.html

- Follow docuentation in OEM Recovery Tools. Use Repo for files (ScanState has all needed files included)
- Rename master_Autounattend.xml to Autounattend.xml and copy to ISO [for both OEM recovery settings (default with autounattend) and win11 tweaks (disable NRO, TPM, etc)]
- Should be a AIO for win11 install + OEM recovery creation. 
- Warning! Auto installs on disk0. You will not be prompted for a drive or any other options (options are set by oem recovery xml). 
- Suggest installing with only the drive you want to install to pluged in / powered on. 

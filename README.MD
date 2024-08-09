# https://www.anarethos.com/recovery_tools.html

- Should be a everything needed for creating a win11 install + OEM recovery creation ISO.
- Assuming you will be using the 'default' OEM Recovery option with the autounattend xml option. 
- Follow docuentation in OEM Recovery Tools. Use Repo for files (ScanState has all needed files included)
- Rename master_Autounattend.xml to Autounattend.xml and copy to ISO [for both OEM recovery settings (default with autounattend) and win11 tweaks (disable NRO, TPM, etc)]
- Warning! Auto installs on disk0. You will not be prompted for a drive or any other options (options are set by oem recovery xml). 
- Suggest installing with only the drive you want to install to pluged in / powered on. 
- Setup whatever during Audit mode. This is also the time you want to be doing the next step in OEM Recovery, so don't just close out too quick. 
- Highly suggest you have drivers downloaded etc before starting this.

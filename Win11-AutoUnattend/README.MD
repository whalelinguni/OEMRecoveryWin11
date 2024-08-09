# Unattended Windows Installation Configuration

This `unattend.xml` file is used to automate the installation of Windows with specific configurations and settings. Below are the detailed settings and configurations applied by this file.

## Rufus Applied Settings

### windowsPE Pass

1. **Bypass TPM, Secure Boot, and RAM Checks**
   - Adds registry entries to bypass the TPM, Secure Boot, and RAM checks.
   - Registry keys:
     - `BypassTPMCheck`
     - `BypassSecureBootCheck`
     - `BypassRAMCheck`

2. **Image Installation**
   - Installs the OS to Partition 4 (Windows) on Disk 0.
   - Shows UI only on error.

3. **Product Key and EULA**
   - Accepts the EULA.
   - Prompts for the product key only on error.

### specialize Pass

1. **Bypass Online Microsoft Account Requirement**
   - Adds a registry entry to bypass the online Microsoft account requirement.
   - Registry key: `BypassNRO`

2. **Disable Auto Update**
   - Adds a registry entry to disable automatic updates from the Windows Store.
   - Registry key: `AutoDownload`

3. **Activate Administrator Account**
   - Runs a PowerShell command to activate the built-in Administrator account.

### oobeSystem Pass

1. **OOBE Configuration**
   - Sets `ProtectYourPC` to 3 to disable data collection and skip privacy questions.

2. **Regional Settings**
   - Sets the regional options to match the current user's settings:
     - Input Locale: `0409:00000409`
     - System Locale: `en-US`
     - User Locale: `en-US`
     - UI Language: `en-US`

3. **Disable BitLocker Automatic Device Encryption**
   - Prevents device encryption by disabling BitLocker.

4. **Audit Mode**
   - Sets the system to enter Audit mode.

## OEM Recovery Partition Settings

### windowsPE Pass

1. **Disk Configuration**
   - Configures the disk with the following partitions:
     - **Partition 1**: Primary, Size = 1024 MB, Label = Recovery, Format = NTFS, TypeID = `de94bba4-06d1-4d40-a16a-bfd50179d6ac`
     - **Partition 2**: EFI, Size = 250 MB, Label = System, Format = FAT32
     - **Partition 3**: MSR, Size = 16 MB
     - **Partition 4**: Primary, Extend = true, Label = Windows, Format = NTFS, Letter = C
   - Wipes the disk before creating the partitions.

2. **Image Installation**
   - Installs the OS to Partition 4 (Windows) on Disk 0.
   - Shows UI only on error.

### specialize Pass

1. **Disable Auto Update**
   - Adds a registry entry to disable automatic updates from the Windows Store.
   - Registry key: `AutoDownload`

2. **Activate Administrator Account**
   - Runs a PowerShell command to activate the built-in Administrator account.

### oobeSystem Pass

1. **Audit Mode**
   - Sets the system to enter Audit mode.

## Usage

1. Place the `unattend.xml` file in the root of your bootable Windows installation media.
2. Boot from the installation media and start the Windows setup.
3. The installation process will follow the configurations and settings specified in the `unattend.xml` file, automating the setup and applying the specified settings.

## Notes

- Ensure the `unattend.xml` file is correctly placed and accessible during the setup process.
- Customize the `ProductKey` value with your actual product key.
- Review and modify the settings as needed to fit your specific requirements.

This configuration file helps streamline the installation process and ensures consistent setup across multiple installations.

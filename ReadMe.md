# ReadMe

Some silly personal stuff here.

## Usage

OOBE (Windows 10 & 11) - Prepare environment for usage.

Sort files by name and execute them in numeric order.

Some info can be found in **CONFIG** folder (files begins with "**!**" character).

## Critical

Important order (next item depends on previous!):

- **xxx_PS1_Execution_Policy_RemoteSigned**

- **xxx_Environment_Variables_SOFT_AHK_BAT**

- **xxx_Environment_Variables_PATH**

- **xxx_Many_Other_Items_Depends_On_Environment_Variables**

## Dependencies

**xxx_AHK_SymLink_Association_RunAs_Startup** depends on:

- **xxx_REG_Import_Settings** (Portable Soft)

- **xxx_AHK_Power_Scheme**

**xxx_SymLinks** depends on:

- **xxx_RAM_DISK_INSTALL**

**xxx_INSTALL** depends on:

- **xxx_REG_Import_Settings** (Installable Soft):

  - **AIM-tk** (Look at **REG_IMPORT\AIM-tk.reg.txt**)

  - **ImDisk** (Look at **REG_IMPORT\ImDisk.reg.txt**)

  - **WFC**

**xxx_BCD_Timeout_Restore_F8** depends on:

- **xxx_BCD_Grub4DOS_evgen_b** (Boot Timeout)

- **xxx_BCD_Grub4DOS_Strelec** (Boot Timeout)

## Temporary Changes

Temporary change OnOpen behaviour of PS1:

- **xxx_PS1_OnOpen_Execute_TEMPORARY** (Execute on open)

- **xxx_DO_SOME_STUFF**

- **xxx_PS1_OnOpen_Edit_ISE** (Edit on open)

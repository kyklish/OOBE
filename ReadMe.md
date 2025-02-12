# ReadMe

Some silly personal stuff here.

## Usage

OOBE (Windows 11) - Prepare environment for usage.

Sort files by name and execute them in numeric order.

Some info can be found in **CONFIG** folder (files begins with "**!**" character).

## Critical

Important order (next item depends on previous!):

- **XXX_PS1_Execution_Policy_RemoteSigned**

- **XXX_Environment_Variables_SOFT_AHK_BAT**

- **XXX_Environment_Variables_PATH**

- **XXX_Many_Other_Items_Depends_On_Environment_Variables**

## Dependencies

**XXX_AHK_SymLink_Association_RunAs_Startup** depends on:

- **XXX_REG_Import_Settings** (Portable Soft)

- **XXX_AHK_Power_Scheme**

**XXX_INSTALL** depends on:

- **XXX_REG_Import_Settings** (Installable Soft):

  - **ImDisk** (Look at **REG_IMPORT\ImDisk.reg.txt**)

  - **WFC**

**XXX_BCD_Timeout_Restore_F8** depends on:

- **XXX_BCD_Grub4DOS_evgen_b** (Boot Timeout)

- **XXX_BCD_Grub4DOS_Strelec** (Boot Timeout)

## Temporary Changes

Temporary change OnOpen behaviour of PS1:

- **XXX_PS1_OnOpen_Execute_TEMPORARY** (Execute on open)

- **XXX_DO_SOME_STUFF**

- **XXX_PS1_OnOpen_Edit_ISE** (Edit on open)

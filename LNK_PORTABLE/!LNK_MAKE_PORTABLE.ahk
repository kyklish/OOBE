#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

; Info: make LNK files portable (change absolute path to %SOFT% varibale)
; Usage: copy this script to folder with LNK files

; FileGetShortcut return path without surrounding double quote!
; FileCreateShortcut automatically adds surrounding double quote if needed!
; X:\PORTABLE\...\file.exe ==> %SOFT%\...\file.exe
sSearch := "^\w:.*\\PORTABLE(?=\\)"
sReplacement := "%SOFT%"

Loop, Files, *.lnk
{
    FileGetShortcut, %A_LoopFileLongPath%, sTarget, sWorkingDir, sArgs, sDescription, sIconFile, iIconNumber
    ; MsgBox %A_LoopFileLongPath%`n%sTarget%`n%sWorkingDir%
    sTarget := RegExReplace(sTarget, sSearch, sReplacement)
    sWorkingDir := RegExReplace(sWorkingDir, sSearch, sReplacement)
    ; MsgBox %A_LoopFileLongPath%`n%sTarget%`n%sWorkingDir%
    FileCreateShortcut, %sTarget%, %A_LoopFileLongPath%, %sWorkingDir%, %sArgs%, %sDescription%, %sIconFile%, , %iIconNumber%
}

MsgBox Done

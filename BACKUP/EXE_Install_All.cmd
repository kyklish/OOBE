@ECHO "Install all .EXE in script's directory"
@ECHO OFF
CLS & CD /D "%~dp0"
FOR %%f IN ("*.exe") DO (
	ECHO Installing: %%f
	"%%f"
)
PAUSE

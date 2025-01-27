@ECHO OFF
CD /D "%~dp0"
CD "CONFIG"
COPY /-Y .gitconfig "%HomeDrive%%HomePath%"
PAUSE

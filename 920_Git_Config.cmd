@ECHO OFF
CD /D "%~dp0"
COPY /-Y ".\CONFIG\.gitconfig" "%HomeDrive%%HomePath%"
PAUSE
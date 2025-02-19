@REM 40% is minimum: 16GB x 0.4 = 6.4GB
@REM The following sleep states are available on MY system:
@REM     Standby (S3)
@REM     Hibernate
@REM     Hybrid Sleep
@REM     Fast Startup (NOT WORK: Up time in Task Manager resets to zero (must be preserved between starts))
@ECHO OFF
REM POWERCFG /HIBERNATE OFF
POWERCFG /HIBERNATE /SIZE 40
PAUSE

:: 40% is minimum: 16GB x 0.4 = 6.4GB
:: POWERCFG /AVAILABLESLEEPSTATES
:: The following sleep states are available on MY system:
::     Standby (S3)
::     Hibernate
::     Hybrid Sleep
::     Fast Startup (NOT WORK: Up time in Task Manager resets to zero (must be preserved between starts))
@ECHO OFF
POWERCFG /HIBERNATE OFF
:: POWERCFG /HIBERNATE /SIZE 40
PAUSE

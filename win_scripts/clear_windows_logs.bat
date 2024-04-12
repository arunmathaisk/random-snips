@echo off
SETLOCAL EnableDelayedExpansion

echo Clearing all Windows Event Logs...

FOR /F "tokens=*" %%G IN ('wevtutil el') DO (
    echo Clearing %%G
    wevtutil cl "%%G"
)

echo All logs have been cleared.
pause

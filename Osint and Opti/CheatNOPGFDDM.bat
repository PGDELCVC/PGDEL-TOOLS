@echo off
title PG DEL GAMING PANEL
mode con cols=100 lines=35
color 5F

set "LOG=PGDEL_LOG.txt"
set "REPORT=PGDEL_REPORT.txt"

if not exist Backup mkdir Backup
if not exist Plugins mkdir Plugins
if not exist Config mkdir Config


:BOOT
cls
echo.
echo          P
timeout /t 1 >nul
cls
echo          PG
timeout /t 1 >nul
cls
echo          PG DEL
timeout /t 1 >nul

goto MENU


:MENU
cls
echo ==========================================
echo          PG DEL GAMING PANEL
echo ==========================================
echo.
echo [1] FPS MAX
echo [2] LOW LATENCY
echo [3] OPTI WINDOWS
echo [4] OPTI CLAVIER
echo [5] OPTI SOURIS
echo [6] REFRESH FIVE M
echo [7] CPU GPU RAM
echo [8] RAPPORT
echo [9] CLEAN TEMP
echo [10] BACKUP
echo [11] PLUGINS
echo [12] CONFIG
echo [13] LOGS
echo [14] CHEAT
echo [15] SPOOF
echo [16] QUIT
echo.

set /p c="PG DEL >> "


if "%c%"=="1" goto FPS
if "%c%"=="2" goto LATENCY
if "%c%"=="3" goto WINDOWS
if "%c%"=="4" goto KEYBOARD
if "%c%"=="5" goto MOUSE
if "%c%"=="6" goto FIVEM
if "%c%"=="7" goto INFO
if "%c%"=="8" goto REPORT
if "%c%"=="9" goto CLEAN
if "%c%"=="10" goto BACKUP
if "%c%"=="11" goto PLUGIN
if "%c%"=="12" goto CONFIG
if "%c%"=="13" goto LOGS
if "%c%"=="14" goto CHEAT
if "%c%"=="15" goto SPOOF
if "%c%"=="16" exit

goto MENU


:FPS
powercfg /setactive SCHEME_MIN
echo FPS MODE OK>>%LOG%
echo Mode performances active
pause
goto MENU


:LATENCY
echo Low latency active>>%LOG%
echo Optimisation latence appliquee
pause
goto MENU


:WINDOWS
del /q /f /s "%TEMP%\*" >nul 2>&1
echo Windows optimise>>%LOG%
echo Nettoyage termine
pause
goto MENU


:KEYBOARD
reg add "HKCU\Control Panel\Keyboard" /v KeyboardDelay /t REG_SZ /d 0 /f >nul
echo Clavier optimise
pause
goto MENU


:MOUSE
reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 1 /f >nul
echo Souris optimise
pause
goto MENU


:FIVEM
set "F=%localappdata%\FiveM\FiveM.app\data"

if exist "%F%" (
rmdir /s /q "%F%\cache" 2>nul
rmdir /s /q "%F%\server-cache" 2>nul
echo Cache FiveM nettoye
) else (
echo FiveM introuvable
)

pause
goto MENU


:INFO
wmic cpu get name
wmic path win32_VideoController get name
wmic computersystem get TotalPhysicalMemory
pause
goto MENU


:REPORT
(
echo PG DEL REPORT
echo Date %date% %time%
echo.
systeminfo
)>%REPORT%

echo Rapport cree
pause
goto MENU


:CLEAN
del /q /f /s "%TEMP%\*" >nul 2>&1
echo Temp nettoye
pause
goto MENU


:BACKUP
reg export "HKCU\Control Panel\Mouse" Backup\mouse.reg /y
reg export "HKCU\Control Panel\Keyboard" Backup\keyboard.reg /y
echo Backup OK
pause
goto MENU


:PLUGIN
dir Plugins
echo.
set /p p="Nom plugin : "

(
echo @echo off
echo echo PG DEL Plugin
echo pause
)>Plugins\%p%.bat

pause
goto MENU


:CONFIG
(
echo PG DEL PANEL
echo THEME=PURPLE
)>Config\config.ini

echo Config OK
pause
goto MENU


:LOGS
type %LOG%
pause
goto MENU


:CHEAT
start "" "https://github.com/PGDELCVC/PGDEL-TOOLS"
goto MENU


:SPOOF
start "" "https://github.com/PGDELCVC/PGDEL-TOOLS"
goto MENU
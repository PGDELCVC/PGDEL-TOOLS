@echo off
setlocal EnableDelayedExpansion
title PG DEL OSINT ULTIMATE
mode con cols=100 lines=35
color 5F

set ROOT=%~dp0
set REPORT=%ROOT%Reports\rapport.txt
set LOG=%ROOT%Logs\activity.log

for %%a in (Reports Logs Plugins Workspace Config Backup) do if not exist "%ROOT%%%a" mkdir "%ROOT%%%a"

call :LOG "Demarrage PG DEL"

:BOOT
cls
echo.
echo        P
timeout /t 1 >nul
cls
echo        PG
timeout /t 1 >nul
cls
echo        PG DEL
timeout /t 1 >nul

cls
echo.
echo ██████╗  ██████╗      ██████╗ ███████╗██╗
echo ██╔══██╗██╔════╝      ██╔══██╗██╔════╝██║
echo ██████╔╝██║  ███╗     ██║  ██║█████╗  ██║
echo ██╔═══╝ ██║   ██║     ██║  ██║██╔══╝  ██║
echo ██║     ╚██████╔╝     ██████╔╝███████╗███████╗
echo.
echo          PG DEL OSINT ULTIMATE
echo          PURPLE TERMINAL EDITION
timeout /t 2 >nul


:MENU
cls
echo.
echo ==========================================
echo          PG DEL OSINT ULTIMATE
echo ==========================================
echo.
echo [1] Analyse systeme
echo [2] Creer rapport
echo [3] Domaine
echo [4] DNS
echo [5] IP
echo [6] URL
echo [7] Hash SHA256
echo [8] Metadonnees fichier
echo [9] Recherche pseudo
echo [10] Verification outils
echo.
echo [11] Backup
echo [12] Export HTML
echo [13] Plugins
echo [14] Logs
echo [15] Configuration
echo [16] Test Internet
echo [17] Nettoyage
echo [18] Mode Analyste
echo [19] Workspace
echo [20] Quitter
echo.

set /p c="PG DEL >> "

if "%c%"=="1" goto SYSTEM
if "%c%"=="2" goto REPORT
if "%c%"=="3" goto DOMAIN
if "%c%"=="4" goto DNS
if "%c%"=="5" goto IP
if "%c%"=="6" goto URL
if "%c%"=="7" goto HASH
if "%c%"=="8" goto META
if "%c%"=="9" goto USER
if "%c%"=="10" goto TOOLS
if "%c%"=="11" goto BACKUP
if "%c%"=="12" goto HTML
if "%c%"=="13" goto PLUGIN
if "%c%"=="14" goto LOGVIEW
if "%c%"=="15" goto CONFIG
if "%c%"=="16" goto NET
if "%c%"=="17" goto CLEAN
if "%c%"=="18" goto ANALYST
if "%c%"=="19" goto WORKSPACE
if "%c%"=="20" exit

goto MENU


:SYSTEM
cls
echo ===== SYSTEME =====
hostname
whoami
wmic cpu get name
wmic path win32_VideoController get name
wmic computersystem get TotalPhysicalMemory
call :LOG "Analyse systeme"
pause
goto MENU


:REPORT
(
echo PG DEL OSINT REPORT
echo Date %date% %time%
echo.
systeminfo
)>"%REPORT%"

echo Rapport cree :
echo %REPORT%
call :LOG "Rapport cree"
pause
goto MENU


:DOMAIN
set /p d="Domaine : "
nslookup %d% >> "%REPORT%"
start "" https://who.is/whois/%d%
call :LOG "Domaine %d%"
pause
goto MENU


:DNS
set /p d="DNS : "
nslookup %d%
pause
goto MENU


:IP
set /p ip="IP : "
nslookup %ip%
start "" https://ipinfo.io/%ip%
pause
goto MENU


:URL
set /p u="URL : "
start "" https://urlscan.io/
echo URL %u% >> "%REPORT%"
pause
goto MENU


:HASH
set /p f="Fichier : "
certutil -hashfile "%f%" SHA256
pause
goto MENU


:META
set /p f="Fichier : "
where exiftool >nul 2>&1
if %errorlevel%==0 (
exiftool "%f%"
) else (
echo ExifTool non installe
)
pause
goto MENU


:USER
set /p user="Pseudo : "
start "" https://github.com/%user%
start "" https://www.reddit.com/user/%user%
pause
goto MENU


:TOOLS
python --version
git --version
exiftool -ver
pause
goto MENU


:BACKUP
xcopy Reports Backup\Reports /E /I /Y >nul
xcopy Logs Backup\Logs /E /I /Y >nul
echo Backup termine
pause
goto MENU


:HTML
(
echo ^<html^>
echo ^<body style="background:black;color:violet"^>
echo ^<h1^>PG DEL REPORT^</h1^>
echo ^<pre^>
type "%REPORT%"
echo ^</pre^>
echo ^</body^>
echo ^</html^>
)>Reports\rapport.html

echo Export HTML OK
pause
goto MENU


:PLUGIN
cls
echo Plugins :
dir Plugins\*.bat /b
echo.
set /p p="Nom nouveau plugin : "
(
echo @echo off
echo echo PG DEL Plugin actif
echo pause
)>Plugins\%p%.bat
pause
goto MENU


:LOGVIEW
type "%LOG%"
pause
goto MENU


:CONFIG
(
echo PG DEL OSINT
echo THEME=PURPLE
echo VERSION=1
)>Config\config.ini
echo Configuration OK
pause
goto MENU


:NET
ping 8.8.8.8 -n 1
pause
goto MENU


:CLEAN
del /q Reports\*.txt >nul 2>&1
echo Nettoyage effectue
pause
goto MENU


:ANALYST
echo.
echo MODE ANALYSTE ACTIVE
echo [OK] Rapports
echo [OK] Logs
echo [OK] Workspace
echo [OK] Plugins
pause
goto MENU


:WORKSPACE
for %%a in (Reports Logs Plugins Workspace Config Backup) do mkdir %%a 2>nul
echo Workspace pret
pause
goto MENU


:LOG
echo [%date% %time%] %~1>>"%LOG%"
goto :eof
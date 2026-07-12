@echo off
setlocal EnableExtensions EnableDelayedExpansion

title PG DEL OSINT PANEL
color 5F
mode con cols=100 lines=35

set "ROOT=%~dp0"
set "REPORT=%ROOT%Reports\report.txt"
set "LOG=%ROOT%Logs\activity.log"

for %%D in (Reports Logs Workspace Backup Config) do (
    if not exist "%ROOT%%%D" mkdir "%ROOT%%%D"
)

goto BOOT


:WRITELOG
echo [%date% %time%] %~1>>"%LOG%"
exit /b



:BOOT
cls
echo.
echo              P
timeout /t 1 >nul
cls
echo.
echo              PG
timeout /t 1 >nul
cls
echo.
echo              PG DEL
timeout /t 1 >nul
goto MENU



:MENU
cls

echo ==========================================
echo          PG DEL OSINT PANEL
echo ==========================================
echo.
echo [1] Domaine
echo [2] DNS
echo [3] IP
echo [4] URL
echo [5] Email format
echo [6] Pseudo public
echo [7] Hash SHA256
echo [8] Infos PC
echo [9] Rapport TXT
echo [10] Export HTML
echo [11] Verification outils
echo [12] Workspace
echo [13] Logs
echo [14] Configuration
echo [15] Nettoyage
echo [16] Backup
echo [17] Ressources OSINT
echo [18] Quitter
echo.

set /p choix="PG DEL >> "

if "%choix%"=="1" goto DOMAIN
if "%choix%"=="2" goto DNS
if "%choix%"=="3" goto IP
if "%choix%"=="4" goto URL
if "%choix%"=="5" goto EMAIL
if "%choix%"=="6" goto USER
if "%choix%"=="7" goto HASH
if "%choix%"=="8" goto INFO
if "%choix%"=="9" goto REPORT
if "%choix%"=="10" goto HTML
if "%choix%"=="11" goto TOOLS
if "%choix%"=="12" goto WORKSPACE
if "%choix%"=="13" goto LOGS
if "%choix%"=="14" goto CONFIG
if "%choix%"=="15" goto CLEAN
if "%choix%"=="16" goto BACKUP
if "%choix%"=="17" goto RESOURCES
if "%choix%"=="18" exit

goto MENU



:DOMAIN
cls
set /p domain="Domaine : "
nslookup %domain%
call :WRITELOG "Domaine %domain%"
pause
goto MENU



:DNS
cls
set /p dns="Nom DNS : "
nslookup %dns%
pause
goto MENU



:IP
cls
set /p ip="Adresse IP : "
nslookup %ip%
pause
goto MENU



:URL
cls
echo Ouverture outils URL publics
start "" "https://urlscan.io"
pause
goto MENU



:EMAIL
cls
set /p mail="Email : "
echo Email analyse : %mail%
pause
goto MENU



:USER
cls
set /p pseudo="Pseudo : "
start "" "https://github.com/%pseudo%"
pause
goto MENU



:HASH
cls
set /p fichier="Fichier : "
certutil -hashfile "%fichier%" SHA256
pause
goto MENU



:INFO
cls
echo CPU :
wmic cpu get name 2>nul

echo.
echo GPU :
wmic path win32_VideoController get name 2>nul

echo.
echo RAM :
wmic computersystem get TotalPhysicalMemory 2>nul

pause
goto MENU



:REPORT
systeminfo > "%REPORT%"
echo Rapport cree :
echo %REPORT%
pause
goto MENU



:HTML
(
echo ^<html^>
echo ^<body style="background:black;color:violet"^>
echo PG DEL OSINT REPORT
echo ^</body^>
echo ^</html^>
)>Reports\report.html

echo HTML cree
pause
goto MENU



:TOOLS
cls
echo Python:
python --version

echo.
echo Git:
git --version

echo.
echo ExifTool:
exiftool -ver

pause
goto MENU



:WORKSPACE
mkdir Workspace\Nouvelle_Enquete
echo Workspace OK
pause
goto MENU



:LOGS
type "%LOG%"
pause
goto MENU



:CONFIG
echo THEME=PURPLE>"Config\config.ini"
echo Configuration OK
pause
goto MENU



:CLEAN
del /q Reports\* >nul 2>&1
echo Nettoyage OK
pause
goto MENU



:BACKUP
xcopy Reports Backup\Reports /E /I /Y
xcopy Logs Backup\Logs /E /I /Y
echo Backup OK
pause
goto MENU



:RESOURCES
start "" "https://who.is"
start "" "https://urlscan.io"
start "" "https://www.google.com"
pause
goto MENU
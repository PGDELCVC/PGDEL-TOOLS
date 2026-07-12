@echo off
setlocal EnableDelayedExpansion

title PG DEL PANEL v3
color 0D
mode con cols=120 lines=45

set "ROOT=%~dp0"

if not exist "%ROOT%Reports" mkdir "%ROOT%Reports"
if not exist "%ROOT%Logs" mkdir "%ROOT%Logs"
if not exist "%ROOT%Workspace" mkdir "%ROOT%Workspace"
if not exist "%ROOT%Backup" mkdir "%ROOT%Backup"
if not exist "%ROOT%Config" mkdir "%ROOT%Config"

goto START


:WRITELOG
echo [%date% %time%] %~1>>"%ROOT%Logs\activity.log"
exit /b


:START
cls

echo.
echo        PPPP   GGG   DDDD  EEEE L
echo        P  P  G     D  D  E    L
echo        PPPP  G GG  D  D  EEE  L
echo        P      GGG  DDDD  EEEE LLLLL
echo.
echo             PG DEL PANEL v3
echo.

timeout /t 2 >nul

goto MENU


:: =========================
:: MENU
:: =========================

:MENU

cls
color 0D

echo.
echo ==============================================================
echo                       PG DEL PANEL v3
echo ==============================================================
echo.

echo       +--------------------------+     +--------------------------+
echo       ^|       SYSTEM             ^|     ^|        GAMING             ^|
echo       +--------------------------+     +--------------------------+
echo       ^| 01 CPU INFO              ^|     ^| 11 FPS BOOST              ^|
echo       ^| 02 GPU INFO              ^|     ^| 12 LOW LATENCY             ^|
echo       ^| 03 RAM INFO              ^|     ^| 13 FIVE M CLEAN             ^|
echo       ^| 04 DISQUE INFO           ^|     ^| 14 GAME MODE                ^|
echo       ^| 05 WINDOWS INFO          ^|     ^| 15 DNS GAMING                ^|
echo       ^| 06 PROCESSUS             ^|     ^| 16 TEST PING                  ^|
echo       ^| 07 SERVICES              ^|     ^| 17 RESEAU                     ^|
echo       ^| 08 TEMP FILES            ^|     ^| 18 DRIVERS                    ^|
echo       ^| 09 CLEAN SYSTEM          ^|     ^|                              ^|
echo       ^| 10 PERFORMANCE           ^|     ^|                              ^|
echo       +--------------------------+     +--------------------------+
echo.

echo       +--------------------------+     +--------------------------+
echo       ^|          OSINT           ^|     ^|          TOOLS             ^|
echo       +--------------------------+     +--------------------------+
echo       ^| 19 DOMAIN                ^|     ^| 30 PYTHON CHECK             ^|
echo       ^| 20 DNS                    ^|     ^| 31 GIT CHECK                 ^|
echo       ^| 21 IP INFO                ^|     ^| 32 EXIFTOOL CHECK            ^|
echo       ^| 22 URL SCAN               ^|     ^| 33 CURL CHECK                 ^|
echo       ^| 23 WHOIS                  ^|     ^| 34 WORKSPACE                  ^|
echo       ^| 24 PSEUDO                 ^|     ^| 35 LOGS                       ^|
echo       ^| 25 EMAIL CHECK            ^|     ^| 36 CONFIG                     ^|
echo       ^| 26 SHA256                 ^|     ^|                              ^|
echo       ^| 27 IMAGE INFO             ^|     ^|                              ^|
echo       ^| 28 REPORT                 ^|     ^|                              ^|
echo       ^| 29 HTML EXPORT            ^|     ^|                              ^|
echo       +--------------------------+     +--------------------------+

echo.
echo       40 BACKUP
echo       41 RESTORE
echo       42 CLEAN REPORTS
echo       43 REFRESH PANEL
echo       44 ABOUT PG DEL
echo       45 QUIT

echo.

set /p choix="                 PG DEL >> "


if "%choix%"=="01" goto CPU
if "%choix%"=="02" goto GPU
if "%choix%"=="03" goto RAM
if "%choix%"=="04" goto DISK
if "%choix%"=="05" goto WINDOWS
if "%choix%"=="06" goto PROCESS
if "%choix%"=="07" goto SERVICES
if "%choix%"=="08" goto TEMP
if "%choix%"=="09" goto CLEAN
if "%choix%"=="10" goto PERFORMANCE

if "%choix%"=="11" goto FPS
if "%choix%"=="12" goto LATENCY
if "%choix%"=="13" goto FIVEM
if "%choix%"=="14" goto GAMEMODE
if "%choix%"=="15" goto DNSGAME
if "%choix%"=="16" goto PING
if "%choix%"=="17" goto NETWORK
if "%choix%"=="18" goto DRIVERS

if "%choix%"=="19" goto DOMAIN
if "%choix%"=="20" goto DNS
if "%choix%"=="21" goto IP
if "%choix%"=="22" goto URL
if "%choix%"=="23" goto WHOIS
if "%choix%"=="24" goto USER
if "%choix%"=="25" goto EMAIL
if "%choix%"=="26" goto HASH
if "%choix%"=="27" goto IMAGE
if "%choix%"=="28" goto REPORT
if "%choix%"=="29" goto HTML

if "%choix%"=="30" goto PYTHON
if "%choix%"=="31" goto GIT
if "%choix%"=="32" goto EXIF
if "%choix%"=="33" goto CURL
if "%choix%"=="34" goto WORKSPACE
if "%choix%"=="35" goto LOGS
if "%choix%"=="36" goto CONFIG

if "%choix%"=="40" goto BACKUP
if "%choix%"=="41" goto RESTORE
if "%choix%"=="42" goto CLEANREPORT
if "%choix%"=="43" goto START
if "%choix%"=="44" goto ABOUT
if "%choix%"=="45" exit

goto MENU
:: =========================
:: SYSTEM MODULES
:: =========================


:CPU
cls
echo.
echo =========================
echo        CPU INFO
echo =========================

wmic cpu get name

call :WRITELOG "CPU INFO"

pause
goto MENU



:GPU
cls
echo.
echo =========================
echo        GPU INFO
echo =========================

wmic path win32_VideoController get name

call :WRITELOG "GPU INFO"

pause
goto MENU



:RAM
cls
echo.
echo =========================
echo        RAM INFO
echo =========================

wmic computersystem get TotalPhysicalMemory

call :WRITELOG "RAM INFO"

pause
goto MENU



:DISK
cls
echo.
echo =========================
echo        DISQUE INFO
echo =========================

wmic logicaldisk get caption,size,freespace

call :WRITELOG "DISK INFO"

pause
goto MENU



:WINDOWS
cls
echo.
echo =========================
echo      WINDOWS INFO
echo =========================

systeminfo

call :WRITELOG "WINDOWS INFO"

pause
goto MENU



:PROCESS
cls
echo.
echo =========================
echo      PROCESSUS ACTIFS
echo =========================

tasklist

call :WRITELOG "PROCESS LIST"

pause
goto MENU



:SERVICES
cls
echo.
echo =========================
echo      SERVICES WINDOWS
echo =========================

sc query

call :WRITELOG "SERVICES"

pause
goto MENU



:TEMP
cls
echo.
echo =========================
echo      TEMP FILES
echo =========================

echo Nettoyage fichiers temporaires...

del /q /f /s "%TEMP%\*" >nul 2>&1

echo Termine.

call :WRITELOG "TEMP CLEAN"

pause
goto MENU



:CLEAN
cls
echo.
echo =========================
echo      CLEAN SYSTEM
echo =========================

del /q /f /s "%TEMP%\*" >nul 2>&1

echo Nettoyage OK.

call :WRITELOG "SYSTEM CLEAN"

pause
goto MENU



:PERFORMANCE
cls
echo.
echo =========================
echo      PERFORMANCE
echo =========================

powercfg /setactive SCHEME_MIN

echo Mode performances active.

call :WRITELOG "PERFORMANCE MODE"

pause
goto MENU




:: =========================
:: GAMING MODULES
:: =========================


:FPS
cls
echo.
echo =========================
echo        FPS BOOST
echo =========================

powercfg /setactive SCHEME_MIN

echo Profil performances active.

call :WRITELOG "FPS BOOST"

pause
goto MENU



:LATENCY
cls
echo.
echo =========================
echo       LOW LATENCY
echo =========================

echo Optimisation latence active.

call :WRITELOG "LOW LATENCY"

pause
goto MENU



:FIVEM
cls
echo.
echo =========================
echo      FIVE M CLEAN
echo =========================


set "FIVE=%localappdata%\FiveM\FiveM.app\data"


if exist "%FIVE%" (

rmdir /s /q "%FIVE%\cache" 2>nul
rmdir /s /q "%FIVE%\server-cache" 2>nul
rmdir /s /q "%FIVE%\server-cache-priv" 2>nul

echo Cache FiveM nettoye.

) else (

echo FiveM non trouve.

)


call :WRITELOG "FIVEM CLEAN"

pause
goto MENU



:GAMEMODE
cls
echo.
echo =========================
echo      WINDOWS GAME MODE
echo =========================

echo Activation du mode jeu Windows.

start ms-settings:gaming-gamemode

call :WRITELOG "GAME MODE"

pause
goto MENU



:DNSGAME
cls
echo.
echo =========================
echo       DNS GAMING
echo =========================

echo DNS actuels :

ipconfig /all | findstr "DNS"

call :WRITELOG "DNS CHECK"

pause
goto MENU



:PING
cls
echo.
echo =========================
echo        TEST PING
echo =========================

set /p host="Serveur : "

ping %host%

call :WRITELOG "PING %host%"

pause
goto MENU



:NETWORK
cls
echo.
echo =========================
echo       RESEAU
echo =========================

ipconfig

call :WRITELOG "NETWORK INFO"

pause
goto MENU



:DRIVERS
cls
echo.
echo =========================
echo       DRIVERS
echo =========================

driverquery

call :WRITELOG "DRIVER LIST"

pause
goto MENU
:: =========================
:: OSINT MODULES
:: =========================


:DOMAIN
cls
echo.
echo =========================
echo       DOMAIN CHECK
echo =========================
echo.

set /p domain="Domaine : "

nslookup %domain%

echo Domaine : %domain%>>"%REPORT%"

call :WRITELOG "DOMAIN %domain%"

pause
goto MENU




:DNS
cls
echo.
echo =========================
echo        DNS LOOKUP
echo =========================
echo.

set /p dns="Domaine DNS : "

nslookup %dns%

call :WRITELOG "DNS %dns%"

pause
goto MENU




:IP
cls
echo.
echo =========================
echo         IP INFO
echo =========================
echo.

set /p ip="Adresse IP : "

nslookup %ip%

echo.
echo Informations publiques :
start "" "https://ipinfo.io/%ip%"

call :WRITELOG "IP %ip%"

pause
goto MENU




:URL
cls
echo.
echo =========================
echo        URL TOOLS
echo =========================
echo.

echo Ouverture outils publics...

start "" "https://urlscan.io"
start "" "https://www.virustotal.com"

call :WRITELOG "URL TOOLS"

pause
goto MENU




:WHOIS
cls
echo.
echo =========================
echo          WHOIS
echo =========================
echo.

set /p who="Domaine : "

start "" "https://who.is/whois/%who%"

call :WRITELOG "WHOIS %who%"

pause
goto MENU




:USER
cls
echo.
echo =========================
echo       PSEUDO PUBLIC
echo =========================
echo.

set /p pseudo="Pseudo : "

echo Recherche publique :

start "" "https://github.com/%pseudo%"
start "" "https://www.reddit.com/user/%pseudo%"

call :WRITELOG "PSEUDO %pseudo%"

pause
goto MENU




:EMAIL
cls
echo.
echo =========================
echo      EMAIL CHECK
echo =========================
echo.

set /p mail="Email : "

echo.
echo Verification du format :

echo %mail% | findstr /R ".*@.*\..*" >nul

if %errorlevel%==0 (
echo Format valide.
) else (
echo Format invalide.
)

call :WRITELOG "EMAIL CHECK"

pause
goto MENU




:HASH
cls
echo.
echo =========================
echo       SHA256 HASH
echo =========================
echo.

set /p file="Fichier : "

certutil -hashfile "%file%" SHA256

call :WRITELOG "HASH"

pause
goto MENU




:IMAGE
cls
echo.
echo =========================
echo      IMAGE METADATA
echo =========================
echo.


where exiftool >nul 2>&1


if %errorlevel%==0 (

set /p img="Image : "

exiftool "%img%"

) else (

echo.
echo ExifTool non installe.
echo Installe ExifTool pour cette fonction.

)


call :WRITELOG "IMAGE INFO"

pause
goto MENU




:REPORT
cls
echo.
echo =========================
echo       RAPPORT OSINT
echo =========================
echo.


(
echo ==========================
echo PG DEL OSINT REPORT
echo ==========================
echo Date : %date% %time%
echo.
echo SYSTEM INFO
systeminfo
echo.
echo NETWORK
ipconfig
)> "%REPORT%"


echo Rapport cree :
echo %REPORT%

call :WRITELOG "REPORT CREATE"

pause
goto MENU




:HTML
cls

echo.
echo =========================
echo       HTML EXPORT
echo =========================
echo.


(
echo ^<html^>
echo ^<head^>
echo ^<title^>PG DEL REPORT^</title^>
echo ^</head^>
echo ^<body style="background:black;color:#bb00ff"^>
echo ^<h1^>PG DEL OSINT REPORT^</h1^>
echo ^<pre^>
type "%REPORT%"
echo ^</pre^>
echo ^</body^>
echo ^</html^>
)> "%ROOT%Reports\report.html"


echo Export HTML termine.

call :WRITELOG "HTML EXPORT"

pause
goto MENU
:: =========================
:: TOOLS MODULES
:: =========================


:PYTHON
cls
echo.
echo =========================
echo       PYTHON CHECK
echo =========================
echo.

python --version

if %errorlevel%==0 (
echo Python OK
) else (
echo Python absent
)

call :WRITELOG "PYTHON CHECK"

pause
goto MENU




:GIT
cls
echo.
echo =========================
echo          GIT CHECK
echo =========================
echo.

git --version

if %errorlevel%==0 (
echo Git OK
) else (
echo Git absent
)

call :WRITELOG "GIT CHECK"

pause
goto MENU




:EXIF
cls
echo.
echo =========================
echo       EXIFTOOL CHECK
echo =========================
echo.

where exiftool

if %errorlevel%==0 (
echo ExifTool OK
) else (
echo ExifTool absent
)

call :WRITELOG "EXIF CHECK"

pause
goto MENU




:CURL
cls
echo.
echo =========================
echo          CURL CHECK
echo =========================
echo.

curl --version

call :WRITELOG "CURL CHECK"

pause
goto MENU




:WORKSPACE
cls
echo.
echo =========================
echo        WORKSPACE
echo =========================
echo.

set /p name="Nom enquete : "

if "%name%"=="" goto MENU

mkdir "%ROOT%Workspace\%name%" 2>nul

echo.
echo Workspace cree :
echo %ROOT%Workspace\%name%

call :WRITELOG "WORKSPACE %name%"

pause
goto MENU




:LOGS
cls
echo.
echo =========================
echo          LOGS
echo =========================
echo.

if exist "%LOG%" (

type "%LOG%"

) else (

echo Aucun log.

)

pause
goto MENU




:CONFIG
cls
echo.
echo =========================
echo       CONFIGURATION
echo =========================
echo.


(
echo PG DEL PANEL v3
echo THEME=PURPLE
echo MODE=OSINT-GAMING
echo VERSION=3.0
)> "%ROOT%Config\config.ini"


echo Configuration sauvegardee.

call :WRITELOG "CONFIG"

pause
goto MENU




:BACKUP
cls
echo.
echo =========================
echo          BACKUP
echo =========================
echo.


xcopy "%ROOT%Reports" "%ROOT%Backup\Reports" /E /I /Y >nul
xcopy "%ROOT%Logs" "%ROOT%Backup\Logs" /E /I /Y >nul
xcopy "%ROOT%Config" "%ROOT%Backup\Config" /E /I /Y >nul


echo Backup termine.

call :WRITELOG "BACKUP"

pause
goto MENU




:RESTORE
cls
echo.
echo =========================
echo         RESTORE
echo =========================
echo.


xcopy "%ROOT%Backup\Reports" "%ROOT%Reports" /E /I /Y >nul
xcopy "%ROOT%Backup\Logs" "%ROOT%Logs" /E /I /Y >nul
xcopy "%ROOT%Backup\Config" "%ROOT%Config" /E /I /Y >nul


echo Restauration terminee.

call :WRITELOG "RESTORE"

pause
goto MENU




:CLEANREPORT
cls
echo.
echo =========================
echo      CLEAN REPORTS
echo =========================
echo.


del /q "%ROOT%Reports\*.txt" >nul 2>&1
del /q "%ROOT%Reports\*.html" >nul 2>&1


echo Rapports nettoyes.

call :WRITELOG "CLEAN REPORTS"

pause
goto MENU




:ABOUT
cls

echo.
echo =================================
echo          PG DEL PANEL v3
echo =================================
echo.
echo Version : 3.0
echo Theme   : Purple Terminal
echo Mode    : OSINT + SYSTEM + GAMING
echo.
echo Merci d'utiliser PG DEL
echo.

pause
goto MENU
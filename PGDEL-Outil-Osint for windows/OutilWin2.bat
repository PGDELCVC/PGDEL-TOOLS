@echo off
chcp 65001 >nul
title DC TOOLBOX v2
color 0B

set "report=%USERPROFILE%\Desktop\DC_Report.txt"

:menu
cls
call :logo

echo.
echo ================= MENU PRINCIPAL =================
echo.
echo [1] Nettoyage Windows
echo [2] Informations PC
echo [3] Outils Systeme
echo [4] Outils Reseau
echo [5] Performances
echo [6] Creer un rapport PC
echo [7] Outils Windows rapides
echo [8] Credits
echo [0] Quitter
echo.

set /p choix=Choix :


if "%choix%"=="1" goto nettoyage
if "%choix%"=="2" goto infos
if "%choix%"=="3" goto systeme
if "%choix%"=="4" goto reseau
if "%choix%"=="5" goto performance
if "%choix%"=="6" goto rapport
if "%choix%"=="7" goto outils
if "%choix%"=="8" goto credits
if "%choix%"=="0" exit

goto menu



:logo
echo.
echo  ██████╗  ██████╗    ████████╗ ██████╗  ██████╗ ██╗
echo  ██╔══██╗██╔════╝    ╚══██╔══╝██╔═══██╗██╔═══██╗██║
echo  ██║  ██║██║            ██║   ██║   ██║██║   ██║██║
echo  ██║  ██║██║            ██║   ██║   ██║██║   ██║██║
echo  ██████╔╝╚██████╗       ██║   ╚██████╔╝╚██████╔╝██║
echo  ╚═════╝  ╚═════╝       ╚═╝    ╚═════╝  ╚═════╝ ╚═╝
echo.
echo              DC TOOLBOX WINDOWS v2
goto :eof



:nettoyage
cls
echo =============== NETTOYAGE =================
echo.
echo [1] Nettoyer fichiers temporaires
echo [2] Nettoyer cache DNS
echo [3] Vider corbeille
echo [4] Nettoyage disque Windows
echo [0] Retour

set /p n=Choix :

if "%n%"=="1" (
del /s /q "%TEMP%\*" >nul 2>&1
del /s /q "C:\Windows\Temp\*" >nul 2>&1
echo Nettoyage termine.
pause
)

if "%n%"=="2" (
ipconfig /flushdns
pause
)

if "%n%"=="3" (
powershell -command "Clear-RecycleBin -Force"
pause
)

if "%n%"=="4" (
cleanmgr
pause
)

goto menu



:infos
cls
echo =============== INFORMATIONS PC ===============
systeminfo
pause
goto menu



:systeme
cls
echo ================= SYSTEME =================
echo.
echo [1] Verification Windows
echo [2] Reparation Windows
echo [3] Gestionnaire des taches
echo [4] Services Windows
echo [5] Gestionnaire peripheriques
echo [0] Retour

set /p s=Choix :

if "%s%"=="1" (
sfc /verifyonly
pause
)

if "%s%"=="2" (
sfc /scannow
pause
)

if "%s%"=="3" start taskmgr

if "%s%"=="4" start services.msc

if "%s%"=="5" start devmgmt.msc

goto menu



:reseau
cls
echo ================= RESEAU =================
echo.
echo [1] Voir IP
echo [2] Tester Internet
echo [3] Reset reseau
echo [4] Voir connexions
echo [0] Retour

set /p r=Choix :

if "%r%"=="1" ipconfig & pause
if "%r%"=="2" ping google.com & pause
if "%r%"=="3" (
netsh winsock reset
netsh int ip reset
pause
)

if "%r%"=="4" netstat -ano & pause

goto menu



:performance
cls
echo =============== PERFORMANCE ===============
echo.
echo [1] Processus actifs
echo [2] Utilisation memoire
echo [3] Batterie
echo [0] Retour

set /p p=Choix :

if "%p%"=="1" tasklist & pause

if "%p%"=="2" (
wmic OS get FreePhysicalMemory,TotalVisibleMemorySize
pause
)

if "%p%"=="3" (
powercfg /batteryreport
pause
)

goto menu



:rapport
cls
echo Creation du rapport...

(
echo ===== DC TOOLBOX REPORT =====
echo.
echo Date :
date /t
echo.
echo PC :
hostname
echo.
systeminfo
echo.
echo RESEAU :
ipconfig
echo.
echo DISQUES :
wmic logicaldisk get size,freespace,caption
) > "%report%"

echo.
echo Rapport cree :
echo %report%

pause
goto menu



:outils
cls
echo =============== OUTILS WINDOWS ===============
echo.
echo [1] Calculatrice
echo [2] Bloc notes
echo [3] Explorateur
echo [4] Panneau configuration
echo [5] Gestion disque
echo [0] Retour

set /p o=Choix :

if "%o%"=="1" start calc
if "%o%"=="2" start notepad
if "%o%"=="3" start explorer
if "%o%"=="4" start control
if "%o%"=="5" start diskmgmt.msc

goto menu



:credits
cls
echo =====================================
echo            DC TOOLBOX
echo =====================================
echo.
echo Version : 2.0
echo Createur : DGDEL
echo.
pause
goto menu
@echo off
setlocal EnableDelayedExpansion
color 0A
title OSINT - Diagnostic Windows

:menu
cls
echo ==========================================================
echo              OSINT / DIAGNOSTIC WINDOWS
echo ==========================================================
echo.
echo 1 - Diagnostic complet
echo 2 - Informations reseau
echo 3 - IPTracer + Logs IP publique
echo 4 - Recherche IP d'un domaine
echo 5 - Afficher IP actuelle
echo 6 - Voir les logs
echo 7 - Quitter
echo.

set /p choix=Votre choix : 

if "%choix%"=="1" goto diagnostic
if "%choix%"=="2" goto reseau
if "%choix%"=="3" goto iptracer
if "%choix%"=="4" goto rechercheip
if "%choix%"=="5" goto afficherip
if "%choix%"=="6" goto logs
if "%choix%"=="7" exit

goto menu


:creation
set datef=%date:/=-%
set heuref=%time::=-%
set heuref=%heuref: =0%

set dossier=Analyse_%datef%_%heuref%
mkdir "%dossier%" 2>nul
goto :eof



:diagnostic
cls
call :creation

echo ==========================================================
echo              DIAGNOSTIC COMPLET
echo ==========================================================
echo.

echo Systeme...
systeminfo > "%dossier%\systeminfo.txt"

echo Utilisateur...
whoami > "%dossier%\utilisateur.txt"

echo Machine...
hostname > "%dossier%\hostname.txt"

echo Configuration IP...
ipconfig /all > "%dossier%\ipconfig.txt"

echo Cache DNS...
ipconfig /displaydns > "%dossier%\dns_cache.txt"

echo Interfaces reseau...
netsh interface show interface > "%dossier%\interfaces.txt"

echo ARP...
arp -a > "%dossier%\arp.txt"

echo Routage...
route print > "%dossier%\routes.txt"

echo MAC...
getmac /v > "%dossier%\mac.txt"

echo Connexions...
netstat -ano > "%dossier%\netstat.txt"

echo Processus...
tasklist > "%dossier%\processus.txt"

echo Services...
net start > "%dossier%\services.txt"

echo Pilotes...
driverquery > "%dossier%\drivers.txt"

echo Disques...
wmic logicaldisk get Name,Size,FreeSpace > "%dossier%\disques.txt"

echo CPU...
wmic cpu get Name,NumberOfCores,MaxClockSpeed > "%dossier%\cpu.txt"

echo Memoire...
wmic computersystem get TotalPhysicalMemory > "%dossier%\memoire.txt"


echo.
echo Diagnostic termine.
echo Resultats :
echo %cd%\%dossier%

pause
goto menu



:reseau
cls
echo ==========================================================
echo              INFORMATIONS RESEAU
echo ==========================================================
echo.

set /p cible=Entrez une IP ou un domaine :

call :creation

echo Test Ping...
ping %cible% > "%dossier%\ping.txt"

echo DNS...
nslookup %cible% > "%dossier%\dns.txt"

echo Trace reseau...
tracert %cible% > "%dossier%\tracert.txt"

echo Configuration reseau...
ipconfig /all > "%dossier%\ipconfig.txt"

echo ARP...
arp -a > "%dossier%\arp.txt"

echo Routes...
route print > "%dossier%\routes.txt"

echo Connexions...
netstat -ano > "%dossier%\netstat.txt"


echo.
echo Resultats sauvegardes :
echo %cd%\%dossier%

pause
goto menu



:iptracer
cls
echo ==========================================================
echo              IPTRACER + SYSTEME DE LOGS
echo ==========================================================
echo.

echo Recuperation IP publique...

for /f %%i in ('powershell -command "(Invoke-WebRequest -UseBasicParsing https://api.ipify.org).Content"') do set IPPUB=%%i


echo.
echo Votre IP publique :
echo %IPPUB%


echo %IPPUB% > IP_publique.txt


if not exist Logs mkdir Logs


echo ===================================== >> Logs\logs.txt
echo Date : %date% >> Logs\logs.txt
echo Heure : %time% >> Logs\logs.txt
echo IP publique : %IPPUB% >> Logs\logs.txt
echo Machine : %computername% >> Logs\logs.txt
echo Utilisateur : %username% >> Logs\logs.txt
echo ===================================== >> Logs\logs.txt


echo.
echo Log cree :
echo Logs\logs.txt


echo.
echo Ouverture du site IPTracer...
start "" "https://www.monippublique.com/"


pause
goto menu



:rechercheip
cls
echo ==========================================================
echo              RECHERCHE IP DOMAINE
echo ==========================================================
echo.

set /p domaine=Entrez un domaine :

nslookup %domaine%


pause
goto menu



:afficherip
cls
echo ==========================================================
echo              IP PUBLIQUE ACTUELLE
echo ==========================================================
echo.

if exist IP_publique.txt (
type IP_publique.txt
) else (
echo Aucune IP sauvegardee.
)

pause
goto menu



:logs
cls
echo ==========================================================
echo              HISTORIQUE DES LOGS
echo ==========================================================
echo.

if exist Logs\logs.txt (
type Logs\logs.txt
) else (
echo Aucun log disponible.
)

pause
goto menu
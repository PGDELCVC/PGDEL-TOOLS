@echo off
setlocal EnableDelayedExpansion
color 0A
title OSINT / Diagnostic Windows

:menu
cls
echo ==========================================================
echo              OSINT / DIAGNOSTIC WINDOWS
echo ==========================================================
echo.
echo 1 - Diagnostic complet
echo 2 - Informations reseau
echo 3 - IPTracer (IP publique)
echo 4 - Recherche IP d'un domaine
echo 5 - Quitter
echo.
set /p choix=Votre choix : 

if "%choix%"=="1" goto diagnostic
if "%choix%"=="2" goto reseau
if "%choix%"=="3" goto iptracer
if "%choix%"=="4" goto rechercheip
if "%choix%"=="5" exit

goto menu


:creation
set datef=%date:/=-%
set heuref=%time::=-%
set heuref=%heuref: =0%

set dossier=Diagnostic_%datef%_%heuref%
mkdir "%dossier%" 2>nul
goto :eof


:diagnostic
cls
call :creation

echo ==========================================================
echo              DIAGNOSTIC COMPLET
echo ==========================================================

echo Debut : %date% %time% > "%dossier%\journal.txt"

echo [1/15] Informations systeme...
systeminfo > "%dossier%\systeminfo.txt"

echo [2/15] Utilisateur...
whoami > "%dossier%\whoami.txt"

echo [3/15] Nom machine...
hostname > "%dossier%\hostname.txt"

echo [4/15] Configuration IP...
ipconfig /all > "%dossier%\ipconfig.txt"

echo [5/15] Cache DNS...
ipconfig /displaydns > "%dossier%\dns_cache.txt"

echo [6/15] Interfaces reseau...
netsh interface show interface > "%dossier%\interfaces.txt"

echo [7/15] Table ARP...
arp -a > "%dossier%\arp.txt"

echo [8/15] Routes...
route print > "%dossier%\routes.txt"

echo [9/15] Adresse MAC...
getmac /v > "%dossier%\mac.txt"

echo [10/15] Connexions...
netstat -ano > "%dossier%\netstat.txt"

echo [11/15] Processus...
tasklist > "%dossier%\processus.txt"

echo [12/15] Services...
net start > "%dossier%\services.txt"

echo [13/15] Disques...
wmic logicaldisk get Name,Size,FreeSpace > "%dossier%\disques.txt"

echo [14/15] CPU...
wmic cpu get Name,NumberOfCores,MaxClockSpeed > "%dossier%\cpu.txt"

echo [15/15] Memoire...
wmic computersystem get TotalPhysicalMemory > "%dossier%\memoire.txt"

echo Fin : %date% %time% >> "%dossier%\journal.txt"

echo.
echo Analyse terminee !
echo Resultats :
echo %cd%\%dossier%

pause
goto menu


:reseau
cls
echo ==========================================================
echo              INFORMATIONS RESEAU
echo ==========================================================

set /p cible=Entrez une IP ou un domaine :

call :creation

echo [1] IP locale...
ipconfig /all > "%dossier%\ipconfig.txt"

echo [2] Table ARP...
arp -a > "%dossier%\arp.txt"

echo [3] Routage...
route print > "%dossier%\route.txt"

echo [4] Connexions...
netstat -ano > "%dossier%\netstat.txt"

echo [5] Ping...
ping %cible% > "%dossier%\ping.txt"

echo [6] DNS...
nslookup %cible% > "%dossier%\dns.txt"

echo [7] Trace reseau...
tracert %cible% > "%dossier%\tracert.txt"

echo.
echo Resultats sauvegardes dans :
echo %cd%\%dossier%

pause
goto menu


:iptracer
cls
echo ==========================================================
echo                 IPTRACER
echo ==========================================================
echo.
echo Ouverture du site Mon IP Publique...
start "" "https://www.monippublique.com/"

pause
goto menu


:rechercheip
cls
echo ==========================================================
echo          RECHERCHE IP PAR DOMAINE
echo ==========================================================
echo.

set /p domaine=Entrez un domaine :

nslookup %domaine%

echo.
pause
goto menu
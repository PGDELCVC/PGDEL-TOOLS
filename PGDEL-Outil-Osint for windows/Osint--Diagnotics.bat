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
echo 3 - IPTracer (recuperer IP publique)
echo 4 - Recherche IP d'un domaine
echo 5 - Afficher IP sauvegardee
echo 6 - Quitter
echo.

set /p choix=Votre choix : 

if "%choix%"=="1" goto diagnostic
if "%choix%"=="2" goto reseau
if "%choix%"=="3" goto iptracer
if "%choix%"=="4" goto rechercheip
if "%choix%"=="5" goto afficherip
if "%choix%"=="6" exit

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

systeminfo > "%dossier%\systeminfo.txt"
whoami > "%dossier%\utilisateur.txt"
hostname > "%dossier%\machine.txt"

ipconfig /all > "%dossier%\ipconfig.txt"
ipconfig /displaydns > "%dossier%\dns_cache.txt"

netsh interface show interface > "%dossier%\interfaces.txt"

arp -a > "%dossier%\arp.txt"
route print > "%dossier%\routes.txt"

getmac /v > "%dossier%\mac.txt"

netstat -ano > "%dossier%\connexions.txt"

tasklist > "%dossier%\processus.txt"

net start > "%dossier%\services.txt"

driverquery > "%dossier%\pilotes.txt"

wmic logicaldisk get Name,Size,FreeSpace > "%dossier%\disques.txt"

wmic cpu get Name,NumberOfCores,MaxClockSpeed > "%dossier%\cpu.txt"

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

ipconfig /all > "%dossier%\configuration_ip.txt"

arp -a > "%dossier%\table_arp.txt"

route print > "%dossier%\routage.txt"

netstat -ano > "%dossier%\connexions.txt"

ping %cible% > "%dossier%\ping.txt"

nslookup %cible% > "%dossier%\dns.txt"

tracert %cible% > "%dossier%\tracert.txt"

echo.
echo Resultats sauvegardes :
echo %cd%\%dossier%

pause
goto menu


:iptracer
cls
echo ==========================================================
echo              IPTRACER - IP PUBLIQUE
echo ==========================================================
echo.

echo Recuperation de votre IP publique...

for /f %%i in ('powershell -command "(Invoke-WebRequest -UseBasicParsing https://api.ipify.org).Content"') do set IPPUB=%%i

echo.
echo Votre IP publique :
echo.
echo %IPPUB%

echo %IPPUB% > IP_publique.txt

echo.
echo IP sauvegardee dans :
echo IP_publique.txt

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
echo              IP PUBLIQUE SAUVEGARDEE
echo ==========================================================
echo.

if exist IP_publique.txt (
    echo Votre derniere IP publique :
    echo.
    type IP_publique.txt
) else (
    echo Aucune IP enregistree.
    echo Utilisez d'abord l'option IPTracer.
)

pause
goto menu
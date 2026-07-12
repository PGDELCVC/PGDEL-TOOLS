@echo off
setlocal EnableDelayedExpansion
color 0A
title OSINT / Diagnostic Windows

echo ==========================================================
echo             OSINT / DIAGNOSTIC WINDOWS
echo ==========================================================
echo.

set /p cible=Entrez une adresse IP ou un nom de domaine :

set datef=%date:/=-%
set heuref=%time::=-%
set heuref=%heuref: =0%

set dossier=OSINT_%datef%_%heuref%
mkdir "%dossier%"

echo Debut : %date% %time% > "%dossier%\journal.txt"
echo Cible : %cible% >> "%dossier%\journal.txt"

echo.
echo [01/20] Informations systeme...
systeminfo > "%dossier%\systeminfo.txt"

echo [02/20] Utilisateur...
whoami > "%dossier%\whoami.txt"

echo [03/20] Nom de la machine...
hostname > "%dossier%\hostname.txt"

echo [04/20] Configuration IP...
ipconfig /all > "%dossier%\ipconfig.txt"

echo [05/20] Cache DNS...
ipconfig /displaydns > "%dossier%\dns_cache.txt"

echo [06/20] Configuration reseau...
netsh interface ip show config > "%dossier%\config_reseau.txt"

echo [07/20] Table ARP...
arp -a > "%dossier%\arp.txt"

echo [08/20] Table de routage...
route print > "%dossier%\routes.txt"

echo [09/20] Adresses MAC...
getmac /v > "%dossier%\mac.txt"

echo [10/20] Connexions reseau...
netstat -ano > "%dossier%\netstat.txt"

echo [11/20] Processus...
tasklist > "%dossier%\processus.txt"

echo [12/20] Services Windows...
net start > "%dossier%\services.txt"

echo [13/20] Pilotes...
driverquery > "%dossier%\drivers.txt"

echo [14/20] Disques...
wmic logicaldisk get Name,Size,FreeSpace > "%dossier%\disques.txt"

echo [15/20] CPU...
wmic cpu get Name,NumberOfCores,MaxClockSpeed > "%dossier%\cpu.txt"

echo [16/20] Memoire...
wmic computersystem get TotalPhysicalMemory > "%dossier%\memoire.txt"

echo [17/20] Variables d'environnement...
set > "%dossier%\variables.txt"

echo [18/20] Test Ping...
ping %cible% > "%dossier%\ping.txt"

echo [19/20] Resolution DNS...
nslookup %cible% > "%dossier%\nslookup.txt"

echo [20/20] Trace reseau...
tracert %cible% > "%dossier%\tracert.txt"

echo.
echo Fin : %date% %time% >> "%dossier%\journal.txt"

echo ==========================================================
echo Analyse terminee
echo Les resultats sont disponibles dans :
echo %cd%\%dossier%
echo ==========================================================

pause
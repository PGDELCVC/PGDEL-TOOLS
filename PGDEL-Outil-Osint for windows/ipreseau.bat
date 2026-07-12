@echo off
title Informations Reseau
color 0A

echo ======================================
echo          INFORMATIONS RESEAU
echo ======================================
echo.

set /p cible=Entrez une IP ou un domaine :

mkdir Resultats 2>nul

echo [1] Configuration IP...
ipconfig /all > Resultats\ipconfig.txt

echo [2] Interfaces reseau...
netsh interface show interface > Resultats\interfaces.txt

echo [3] Adresse MAC...
getmac /v > Resultats\mac.txt

echo [4] Table ARP...
arp -a > Resultats\arp.txt

echo [5] Table de routage...
route print > Resultats\routes.txt

echo [6] Connexions actives...
netstat -ano > Resultats\netstat.txt

echo [7] Test de connexion...
ping %cible% > Resultats\ping.txt

echo [8] Resolution DNS...
nslookup %cible% > Resultats\dns.txt

echo [9] Chemin reseau...
tracert %cible% > Resultats\tracert.txt

echo [10] Configuration pare-feu...
netsh advfirewall show allprofiles > Resultats\firewall.txt

echo.
echo ======================================
echo Analyse terminee
echo Fichiers dans le dossier Resultats
echo ======================================

pause
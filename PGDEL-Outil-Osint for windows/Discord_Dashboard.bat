@echo off
setlocal EnableDelayedExpansion

title Discord Dashboard
color D
mode 120,40

set server=My Gaming Community
set members=80462
set online=44028
set messages=52300
set boosts=42
set level=12


:MENU
cls

echo ===============================================================
echo                 DISCORD SERVER DASHBOARD PRO
echo                    SIMULATION MODE
echo ===============================================================
echo.
echo Serveur : %server%
echo.
echo [1] Tableau de bord
echo [2] Liste membres actifs
echo [3] Activite des salons
echo [4] Logs serveur
echo [5] Moderation
echo [6] Statistiques
echo [7] Parametres serveur
echo [8] Mode animation temps reel
echo [0] Quitter
echo.

set /p choix="Choix : "


if "%choix%"=="1" goto DASH
if "%choix%"=="2" goto USERS
if "%choix%"=="3" goto CHANNELS
if "%choix%"=="4" goto LOGS
if "%choix%"=="5" goto MOD
if "%choix%"=="6" goto STATS
if "%choix%"=="7" goto SETTINGS
if "%choix%"=="8" goto LIVE
if "%choix%"=="0" exit

goto MENU



:DASH
cls

echo ================= DASHBOARD =================

set /a online=20+%random%%%80
set /a messages+=%random%%%50

echo.
echo Serveur : %server%
echo Etat : ONLINE
echo Membres total : %members%
echo Connectes : %online%
echo Messages : %messages%
echo Boosts : %boosts%
echo Niveau serveur : %level%

pause
goto MENU



:USERS
cls

echo =============== MEMBRES ACTIFS ===============

for /l %%i in (1,1,15) do (

set /a id=!random!%%99999
set /a ping=20+!random!%%100

echo [ONLINE] User_!id!  Ping !ping!ms
)

pause
goto MENU



:CHANNELS
cls

echo =============== ACTIVITE SALONS ===============

echo.
echo #general
echo    Messages/min : %random%

echo.
echo #gaming
echo    Joueurs connectes : %random%

echo.
echo #support
echo    Tickets ouverts : %random%

echo.
echo 🔊 Salon vocal
echo    Utilisateurs : %random%

pause
goto MENU



:LOGS
cls

echo ================= LOGS =================

echo [12:01] Connexion utilisateur acceptee
echo [12:02] Message envoye #general
echo [12:04] Reaction ajoutee
echo [12:06] Moderation automatique active
echo [12:08] Sauvegarde serveur terminee

pause
goto MENU



:MOD
cls

echo ============== MODERATION ==============

echo.
echo 1 - Scanner messages
echo 2 - Nettoyer salon
echo 3 - Voir sanctions

set /p mod="Option : "

if "%mod%"=="1" (
echo Scan termine : aucun probleme detecte.
)

if "%mod%"=="2" (
echo Nettoyage simulation termine.
)

if "%mod%"=="3" (
echo Aucune sanction.
)

pause
goto MENU



:STATS
cls

echo ============== STATISTIQUES ==============

set /a joins=%random%%%100
set /a leaves=%random%%%20

echo.
echo Nouveaux membres aujourd'hui : %joins%
echo Departs aujourd'hui : %leaves%
echo Messages/jour : %messages%
echo Temps vocal : %random% heures

pause
goto MENU



:SETTINGS
cls

echo ============== PARAMETRES ==============

echo Serveur : %server%
echo Protection : ACTIVE
echo AutoMod : ACTIVE
echo Logs : ACTIVE
echo Verification : ACTIVE

pause
goto MENU



:LIVE
cls

echo ============ LIVE SERVER MONITOR ============
echo CTRL+C pour quitter
echo.

:LOOP

set /a online=20+%random%%%100
set /a messages+=%random%%%10

cls

echo ===========================================
echo LIVE DISCORD MONITOR SIMULATION
echo ===========================================
echo.
echo Membres en ligne : %online%
echo Messages/min : %random%
echo Ping serveur : %random% ms
echo CPU bot : %random%%%
echo.

echo Activite :
echo [OK] Message recu
echo [OK] Reaction ajoutee
echo [OK] Utilisateur connecte
echo [OK] Moderation active

timeout /t 3 >nul

goto LOOP
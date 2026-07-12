@echo off
setlocal EnableDelayedExpansion

title FiveM Economy Simulator - DEMO
color 0A
mode 100,35

set argent=0
set niveau=1
set joueurs=0

:MENU
cls

echo ==================================================
echo          FIVEM SERVER ECONOMY SIMULATOR
echo              MODE ROLEPLAY - DEMO
echo ==================================================
echo.
echo Joueurs connectes : !joueurs!
echo Niveau serveur    : !niveau!
echo Solde fictif      : !argent! EUR RP
echo.
echo [1] Rejoindre le serveur
echo [2] Effectuer une mission
echo [3] Recompense evenement
echo [4] Coffre serveur
echo [5] Quitter
echo.

set /p choix="Choix : "

if "%choix%"=="1" goto JOIN
if "%choix%"=="2" goto MISSION
if "%choix%"=="3" goto EVENT
if "%choix%"=="4" goto BANK
if "%choix%"=="5" exit

goto MENU


:JOIN
cls
echo Connexion au serveur FiveM...
timeout /t 2 >nul

set /a joueurs+=1

echo.
echo Joueur connecte !
echo ID session : %random%
echo.
pause
goto MENU



:MISSION
cls

set /a gain=50+%random%%%450

echo =================================
echo       MISSION TERMINEE
echo =================================
echo.
echo Contrat RP valide
echo Recompense :
echo + !gain! EUR RP
echo.

set /a argent+=gain

echo Transaction serveur :
echo [OK] Argent ajoute au portefeuille RP

timeout /t 2 >nul

goto MENU



:EVENT
cls

set /a bonus=500+%random%%%1500

echo =================================
echo       EVENT SERVEUR
echo =================================
echo.
echo Evenement communautaire termine !
echo Bonus :
echo + !bonus! EUR RP
echo.

set /a argent+=bonus

timeout /t 2 >nul

goto MENU



:BANK
cls

echo =================================
echo       COMPTE BANQUE RP
echo =================================
echo.
echo Solde :
echo !argent! EUR RP
echo.
echo Historique :
echo - Mission automatique
echo - Event serveur
echo - Bonus connexion

pause

goto MENU
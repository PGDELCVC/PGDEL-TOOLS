@echo off
setlocal EnableDelayedExpansion

title FiveM Server Monitor 
color D
mode 120,40

set players=472
set max=128
set tick=0

:START
cls

echo ===============================================================
echo              FIVEM SERVER MONITOR
echo                 DEMO / SIMULATION
echo ===============================================================
echo.

set /a change=%random%%%8

if %change% LSS 4 (
    set /a players+=1
)

if %change% GEQ 6 (
    set /a players-=1
)

if %players% LSS 0 set players=0
if %players% GTR 128 set players=128


echo STATUS : ONLINE
echo REGION : EUROPE
echo SERVER : ROLEPLAY CITY
echo.

echo JOUEURS CONNECTES : !players! / !max!
echo.

echo ===============================================================
echo JOUEURS ACTIFS
echo ===============================================================

for /l %%i in (1,1,10) do (
    set /a id=!random!%%9999
    set /a ping=20+!random!%%80

    echo [%%i] Player_!id!      Ping: !ping! ms     ONLINE
)


echo.
echo ===============================================================
echo ACTIVITE SERVEUR
echo ===============================================================

set /a cpu=20+%random%%%60
set /a ram=30+%random%%%50
set /a uptime=1+%random%%%99

echo CPU Serveur : !cpu!%%
echo RAM         : !ram!%%
echo Uptime      : !uptime! heures
echo.

echo Logs :
echo [OK] Connexion joueur acceptee
echo [OK] Synchronisation monde
echo [OK] Anti-Cheat actif
echo [OK] Systeme economique charge

echo.
echo Mise a jour dans 3 secondes...

timeout /t 3 >nul

goto START
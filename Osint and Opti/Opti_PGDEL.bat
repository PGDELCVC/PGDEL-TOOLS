@echo off
title Gaming Optimizer - Windows
color 0A

:menu
cls
echo ==========================================
echo          GAMING OPTIMIZER WINDOWS
echo ==========================================
echo.
echo [1] Optimisation complete Gaming
echo [2] Nettoyage fichiers temporaires
echo [3] Optimisation reseau / Ping
echo [4] Mode Performances Ultimes
echo [5] Activer Windows Game Mode
echo [6] Reduire services arriere-plan
echo [7] Reparer fichiers Windows
echo [8] TOUT OPTIMISER
echo [0] Quitter
echo.
set /p choix="Choix : "

if "%choix%"=="1" goto full
if "%choix%"=="2" goto clean
if "%choix%"=="3" goto network
if "%choix%"=="4" goto power
if "%choix%"=="5" goto gamemode
if "%choix%"=="6" goto services
if "%choix%"=="7" goto repair
if "%choix%"=="8" goto full
if "%choix%"=="0" exit

goto menu


:full
call :clean
call :network
call :power
call :gamemode
call :services
goto end


:clean
cls
echo Nettoyage...

del /s /f /q %temp%\* >nul 2>&1
del /s /f /q C:\Windows\Temp\* >nul 2>&1

cleanmgr /verylowdisk

echo Nettoyage termine.
pause
goto menu


:network
cls
echo Optimisation reseau...

ipconfig /flushdns

netsh int tcp set global autotuninglevel=normal
netsh int tcp set global rss=enabled

echo Reseau optimise.
pause
goto menu


:power
cls
echo Activation performances maximales...

powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 >nul

powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61

echo Mode performances ultimes active.
pause
goto menu


:gamemode
cls
echo Activation Game Mode...

reg add "HKCU\Software\Microsoft\GameBar" /v AllowAutoGameMode /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 1 /f

echo Game Mode active.
pause
goto menu


:services
cls
echo Reduction services inutiles...

sc stop DiagTrack >nul 2>&1
sc config DiagTrack start=disabled >nul 2>&1

sc stop dmwappushservice >nul 2>&1
sc config dmwappushservice start=disabled >nul 2>&1

echo Services ajustes.
pause
goto menu


:repair
cls
echo Verification Windows...

sfc /scannow

echo Verification terminee.
pause
goto menu


:end
cls
echo =====================================
echo OPTIMISATION TERMINEE
echo Redemarre le PC pour appliquer.
echo =====================================
pause
goto menu
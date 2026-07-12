@echo off
title PC Performance Manager PRO V2
color 0A
mode 100,35

:: ADMIN CHECK
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Lance ce programme en Administrateur.
    pause
    exit
)

:: ===============================
:: CREATION RESTAURATION
:: ===============================

echo Creation point de restauration...
powershell -Command "Checkpoint-Computer -Description 'Avant Performance Manager V2' -RestorePointType MODIFY_SETTINGS" >nul 2>&1


:MENU
cls
echo =====================================================
echo             PC PERFORMANCE MANAGER PRO V2
echo =====================================================
echo.
echo  [1] Informations PC
echo  [2] Profil NORMAL
echo  [3] Profil PERFORMANCE
echo  [4] Profil GAMING COMPETITIF
echo.
echo  [5] Nettoyage complet
echo  [6] Reparation Windows
echo  [7] Optimisation SSD/HDD
echo  [8] Optimisation reseau
echo  [9] Optimisation Windows visuelle
echo.
echo  [10] Annuler optimisations principales
echo.
echo  [0] Quitter
echo.

set /p choix=Votre choix :


if "%choix%"=="1" goto INFO
if "%choix%"=="2" goto NORMAL
if "%choix%"=="3" goto PERFORMANCE
if "%choix%"=="4" goto GAMING
if "%choix%"=="5" goto CLEAN
if "%choix%"=="6" goto REPAIR
if "%choix%"=="7" goto DISK
if "%choix%"=="8" goto NETWORK
if "%choix%"=="9" goto VISUAL
if "%choix%"=="10" goto UNDO
if "%choix%"=="0" exit

goto MENU



:INFO
cls
echo ================================
echo INFORMATIONS SYSTEME
echo ================================
echo.

systeminfo | findstr /C:"OS Name" /C:"OS Version" /C:"System Type"

echo.
wmic cpu get name
wmic computersystem get TotalPhysicalMemory

echo.
wmic path win32_videocontroller get name

pause
goto MENU



:NORMAL
cls
echo PROFIL NORMAL

powercfg /setactive SCHEME_BALANCED

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 1 /f

echo Profil normal applique.
pause
goto MENU



:PERFORMANCE
cls
echo PROFIL PERFORMANCE

powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61

powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61


:: Desactiver animations
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 0 /f


:: Priorite systeme
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f

echo Performance active.
pause
goto MENU



:GAMING
cls
echo PROFIL GAMING COMPETITIF


:: Mode jeu
reg add "HKCU\Software\Microsoft\GameBar" /v AllowAutoGameMode /t REG_DWORD /d 1 /f


:: GPU Hardware Scheduling
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f


:: Priorite jeux
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v Priority /t REG_DWORD /d 6 /f

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v GPU Priority /t REG_DWORD /d 8 /f


:: Reseau
netsh int tcp set global autotuninglevel=normal

echo Mode gaming applique.
pause
goto MENU



:CLEAN
cls
echo NETTOYAGE COMPLET


del /s /f /q "%TEMP%\*" >nul 2>&1

del /s /f /q "C:\Windows\Temp\*" >nul 2>&1


DISM /Online /Cleanup-Image /StartComponentCleanup


cleanmgr /verylowdisk


echo Nettoyage termine.
pause
goto MENU



:REPAIR
cls
echo REPARATION WINDOWS

sfc /scannow

DISM /Online /Cleanup-Image /RestoreHealth

echo Reparation terminee.
pause
goto MENU



:DISK
cls
echo OPTIMISATION DISQUE


wmic diskdrive get model,mediatype


echo.
echo Optimisation...

defrag C: /O


echo Termine.
pause
goto MENU



:NETWORK
cls
echo OPTIMISATION RESEAU


ipconfig /flushdns

netsh winsock reset

netsh int ip reset


echo Reseau optimise.
pause
goto MENU



:VISUAL
cls
echo OPTIMISATION VISUELLE


reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f


reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 0 /f


echo Interface allegee.
pause
goto MENU



:UNDO
cls
echo RESTAURATION DES REGLAGES PRINCIPAUX


powercfg /setactive SCHEME_BALANCED


reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /f


reg delete "HKCU\Software\Microsoft\GameBar" /v AllowAutoGameMode /f


echo Reglages principaux annules.
echo Un redemarrage est conseille.
pause
goto MENU
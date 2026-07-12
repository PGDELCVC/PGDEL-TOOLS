@echo off
title Windows 11 Gaming Optimizer - Performance Mode
color 0A

:: Vérification administrateur
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Ce script doit etre lance en administrateur.
    pause
    exit
)

echo ==========================================
echo       WINDOWS 11 GAMING OPTIMIZER
echo ==========================================
echo.

:: Création d'un point de restauration
echo Creation d'un point de restauration...
powershell -Command "Checkpoint-Computer -Description 'Avant optimisation gaming' -RestorePointType MODIFY_SETTINGS" >nul 2>&1


:: ------------------------------------------------
:: PLAN D'ALIMENTATION PERFORMANCE
:: ------------------------------------------------

echo Activation du mode performances maximales...

powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 >nul
powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61


:: ------------------------------------------------
:: MODE JEU WINDOWS
:: ------------------------------------------------

echo Activation du Game Mode...

reg add "HKCU\Software\Microsoft\GameBar" /v AllowAutoGameMode /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 1 /f


:: ------------------------------------------------
:: PRIORITE GPU WINDOWS
:: ------------------------------------------------

echo Optimisation GPU...

reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f


:: ------------------------------------------------
:: DESACTIVATION DES EFFETS VISUELS
:: ------------------------------------------------

echo Reduction effets Windows...

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f


:: ------------------------------------------------
:: OPTIMISATION EXPLORATEUR
:: ------------------------------------------------

echo Optimisation Explorer...

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewAlphaSelect /t REG_DWORD /d 0 /f


:: ------------------------------------------------
:: REDUCTION TELEMETRIE
:: ------------------------------------------------

echo Reduction telemetry...

sc stop DiagTrack >nul 2>&1
sc config DiagTrack start=disabled >nul 2>&1

sc stop dmwappushservice >nul 2>&1
sc config dmwappushservice start=disabled >nul 2>&1


:: ------------------------------------------------
:: OPTIMISATION RESEAU GAMING
:: ------------------------------------------------

echo Optimisation reseau...

netsh int tcp set global autotuninglevel=normal
netsh int tcp set global rss=enabled
netsh int tcp set global chimney=enabled

ipconfig /flushdns


:: ------------------------------------------------
:: DESACTIVATION NAGLES ALGORITHME TCP
:: ------------------------------------------------

echo Ajustement latence TCP...

for /f "tokens=*" %%i in ('wmic nic where "NetEnabled=true" get GUID ^| find "-"') do (
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%%i" /v TcpAckFrequency /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%%i" /v TCPNoDelay /t REG_DWORD /d 1 /f
)


:: ------------------------------------------------
:: NETTOYAGE TEMP
:: ------------------------------------------------

echo Nettoyage fichiers temporaires...

del /s /f /q "%temp%\*" >nul 2>&1
del /s /f /q "C:\Windows\Temp\*" >nul 2>&1

cleanmgr /verylowdisk


:: ------------------------------------------------
:: OPTIMISATION WINDOWS UPDATE EN ARRIERE PLAN
:: ------------------------------------------------

echo Limitation activite Windows Update...

reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v IsContinuousInnovationOptedIn /t REG_DWORD /d 0 /f


:: ------------------------------------------------
:: DESACTIVATION DES APPLICATIONS EN ARRIERE PLAN
:: ------------------------------------------------

echo Limitation applications background...

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f


:: ------------------------------------------------
:: PRIORITE JEUX
:: ------------------------------------------------

echo Optimisation multimedia...

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v GPU Priority /t REG_DWORD /d 8 /f

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v Priority /t REG_DWORD /d 6 /f


:: ------------------------------------------------
:: REDUIRE LATENCE SOURIS
:: ------------------------------------------------

echo Ajustement souris...

reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 0 /f
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 0 /f


:: ------------------------------------------------
:: VIDER CACHE DNS
:: ------------------------------------------------

ipconfig /flushdns


echo.
echo ==========================================
echo OPTIMISATION TERMINEE
echo Redemarrage conseille.
echo ==========================================

pause
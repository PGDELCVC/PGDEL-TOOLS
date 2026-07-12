@echo off
title PG DEL Ultimate Gaming Optimizer
mode con cols=100 lines=40
color 5F

set REPORT=PG_DEL_Rapport.txt


:: ============================
:: LOGO ANIME
:: ============================

cls
echo.
echo        P
timeout /t 1 >nul
cls
echo.
echo        PG
timeout /t 1 >nul
cls
echo.
echo        PG DEL
timeout /t 1 >nul
cls

echo.
echo   ██████╗  ██████╗      ██████╗ ███████╗██╗     
echo   ██╔══██╗██╔════╝      ██╔══██╗██╔════╝██║     
echo   ██████╔╝██║  ███╗     ██║  ██║█████╗  ██║     
echo   ██╔═══╝ ██║   ██║     ██║  ██║██╔══╝  ██║     
echo   ██║     ╚██████╔╝     ██████╔╝███████╗███████╗
echo.
echo            PRO GAMER EDITION
echo.
timeout /t 2 >nul


:: ============================
:: DETECTION SYSTEME
:: ============================

:detect

cls
echo =====================================
echo        DETECTION HARDWARE
echo =====================================

echo. > %REPORT%

echo DATE >> %REPORT%
date /t >> %REPORT%

echo CPU >> %REPORT%
wmic cpu get name >> %REPORT%

echo RAM >> %REPORT%
wmic computersystem get TotalPhysicalMemory >> %REPORT%

echo GPU >> %REPORT%
wmic path win32_VideoController get name >> %REPORT%


wmic cpu get name
echo.

wmic path win32_VideoController get name
echo.

wmic computersystem get TotalPhysicalMemory

pause



:menu

cls
echo.
echo =================================================
echo              PG DEL ULTIMATE
echo =================================================
echo.
echo [1] BOOST FPS MAXIMUM
echo.
echo [2] MODE LOW LATENCY
echo.
echo [3] OPTIMISATION WINDOWS GAMING
echo.
echo [4] OPTIMISATION XBOX
echo.
echo [5] OPTIMISATION STEAM / DISCORD
echo.
echo [6] CREER RAPPORT AVANT/APRES
echo.
echo [7] TOUT FAIRE
echo.
echo [0] QUITTER
echo.

set /p choix="PG DEL >> "


if "%choix%"=="1" goto fps
if "%choix%"=="2" goto latency
if "%choix%"=="3" goto windows
if "%choix%"=="4" goto xbox
if "%choix%"=="5" goto apps
if "%choix%"=="6" goto report
if "%choix%"=="7" goto all
if "%choix%"=="0" exit

goto menu



:: ============================
:: BARRE PROGRESSION
:: ============================

:bar
cls
echo.
echo APPLICATION DES OPTIMISATIONS
echo.
echo [############----------------]
timeout /t 1 >nul
cls
echo.
echo APPLICATION DES OPTIMISATIONS
echo.
echo [####################--------]
timeout /t 1 >nul
cls
echo.
echo APPLICATION DES OPTIMISATIONS
echo.
echo [############################]
timeout /t 1 >nul
goto :eof



:fps

call :bar

echo Mode FPS MAXIMUM >> %REPORT%

powercfg -setactive SCHEME_MIN

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f

reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /d 0 /f

echo Profil FPS applique.
pause
goto menu



:latency

call :bar

echo Mode faible latence >> %REPORT%

reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 38 /f

netsh int tcp set global autotuninglevel=normal

echo LOW LATENCY ACTIVE
pause
goto menu



:windows

call :bar

echo Optimisation Windows >> %REPORT%

del /s /f /q %temp%\* >nul 2>&1

ipconfig /flushdns

echo Windows optimise.
pause
goto menu



:xbox

call :bar

echo Optimisation Xbox >> %REPORT%

reg add "HKCU\Software\Microsoft\GameBar" /v AllowAutoGameMode /t REG_DWORD /d 1 /f

reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 1 /f

echo Xbox Game Mode configure.
pause
goto menu



:apps

call :bar

echo Steam Discord optimisation >> %REPORT%

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f

echo Applications optimisees.
pause
goto menu



:report

cls

echo RAPPORT FINAL >> %REPORT%

echo CPU >> %REPORT%
wmic cpu get name >> %REPORT%

echo GPU >> %REPORT%
wmic path win32_VideoController get name >> %REPORT%

echo RAM >> %REPORT%
wmic computersystem get TotalPhysicalMemory >> %REPORT%

echo Rapport cree :
echo %REPORT%

pause
goto menu



:all

call :fps
call :latency
call :windows
call :xbox
call :apps

goto menu
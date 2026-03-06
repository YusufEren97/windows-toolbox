@echo off
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /b
)
cd /d "%~dp0"

chcp 65001 >nul 2>&1
title Port Killer V1.0
color 0C
mode con cols=90 lines=46

:menu
cls
echo.
echo  ██████╗  ██████╗ ██████╗ ████████╗    ██╗  ██╗██╗██╗     ██╗     ███████╗██████╗
echo  ██╔══██╗██╔═══██╗██╔══██╗╚══██╔══╝    ██║ ██╔╝██║██║     ██║     ██╔════╝██╔══██╗
echo  ██████╔╝██║   ██║██████╔╝   ██║       █████╔╝ ██║██║     ██║     █████╗  ██████╔╝
echo  ██╔═══╝ ██║   ██║██╔══██╗   ██║       ██╔═██╗ ██║██║     ██║     ██╔══╝  ██╔══██╗
echo  ██║     ╚██████╔╝██║  ██║   ██║       ██║  ██╗██║███████╗███████╗███████╗██║  ██║
echo  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝       ╚═╝  ╚═╝╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝
echo.
echo     ╔══════════════════════════════════════════════════════════════════════╗
echo     ║        PORT MANAGEMENT AND CLEANUP TOOL ^| BY YUSUFEREN97             ║
echo     ╚══════════════════════════════════════════════════════════════════════╝
echo.
echo    [1] Kill Port
echo    [2] Query Port
echo    [3] List All Open Ports
echo    [4] Exit
echo.
set /p choice="  » Make your choice (1-4): "

if "%choice%"=="1" goto kill_port
if "%choice%"=="2" goto query_port
if "%choice%"=="3" goto list_ports
if "%choice%"=="4" exit
echo.
echo   [!] Invalid choice, please try again.
timeout /t 1 >nul
goto menu

:list_ports
cls
echo.
echo   ╔══════════════════════════════════════════════════════════════════════╗
echo   ║                    ALL LISTENING PORTS                               ║
echo   ╚══════════════════════════════════════════════════════════════════════╝
echo.
echo    Proto   Local Address                  PID
echo    ─────   ─────────────                  ───
setlocal enabledelayedexpansion
for /f "tokens=1,2,5" %%a in ('netstat -aon ^| findstr LISTENING') do (
    set "addr=%%b                              "
    set "addr=!addr:~0,30!"
    echo    %%a     !addr! %%c
)
endlocal
echo.
pause
goto menu

:kill_port
cls
echo.
echo   ╔══════════════════════════════════════════════════════════════════════╗
echo   ║                          KILL PORT                                   ║
echo   ╚══════════════════════════════════════════════════════════════════════╝
echo.
set "port="
set /p port="  » Enter the PORT number to kill: "
if "%port%"=="" goto menu
echo %port%| findstr /R "^[0-9]*$" >nul 2>&1
if errorlevel 1 (
    echo.
    echo   [✗] Error: Please enter numbers only!
    echo.
    pause
    goto menu
)

set "is_safe=0"
for %%p in (53 135 139 445 3389) do (
    if "%port%"=="%%p" set "is_safe=1"
)
if "%is_safe%"=="1" (
    echo.
    echo   [!!!] WARNING: Port %port% is critical for the system!
    echo   [!!!] This operation has been blocked for security reasons.
    echo.
    pause
    goto menu
)

echo.
echo   [~] Scanning port %port%...

set "pid="
for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":%port% " ^| findstr LISTENING') do set pid=%%a

if "%pid%"=="" (
    echo.
    echo   [✗] No active process found using port %port%.
    echo.
    pause
    goto menu
)

set "pname=Unknown"
for /f "tokens=1" %%n in ('tasklist /FI "PID eq %pid%" /NH /FO CSV 2^>nul ^| findstr /v "info"') do (
    set "pname=%%~n"
)

echo   [✓] Detected PID       : %pid%
echo   [✓] Process Name       : %pname%
echo.
echo   [~] Terminating...

taskkill /F /PID %pid% >nul 2>&1
echo.
echo   [✓] Port %port% successfully killed! PID: %pid%

echo.
pause
goto menu

:query_port
cls
echo.
echo   ╔══════════════════════════════════════════════════════════════════════╗
echo   ║                         QUERY PORT                                   ║
echo   ╚══════════════════════════════════════════════════════════════════════╝
echo.
set "port="
set /p port="  » Enter the PORT number to query: "
if "%port%"=="" goto menu
echo %port%| findstr /R "^[0-9]*$" >nul 2>&1
if errorlevel 1 (
    echo.
    echo   [✗] Error: Please enter numbers only!
    echo.
    pause
    goto menu
)

echo.
echo   [~] Scanning port %port%...

set "pid="
for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":%port% " ^| findstr LISTENING') do set pid=%%a

if "%pid%"=="" (
    echo.
    echo   [✗] No active process found using port %port%.
    echo.
    pause
    goto menu
)

set "pname=Unknown"
for /f "tokens=1" %%n in ('tasklist /FI "PID eq %pid%" /NH /FO CSV 2^>nul ^| findstr /v "info"') do (
    set "pname=%%~n"
)

echo   [✓] Port              : %port%
echo   [✓] PID               : %pid%
echo   [✓] Process Name      : %pname%
echo.
pause
goto menu
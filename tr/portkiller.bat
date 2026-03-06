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
echo     ║        PORT YÖNETİM VE TEMİZLİK ARACI ^| BY YUSUFEREN97               ║
echo     ╚══════════════════════════════════════════════════════════════════════╝
echo.
echo    [1] Portu Yok Et
echo    [2] Portu Sorgula
echo    [3] Tüm Açık Portları Listele
echo    [4] Çıkış
echo.
set /p secim="  » Seçiminizi yapın (1-4): "

if "%secim%"=="1" goto kill_port
if "%secim%"=="2" goto query_port
if "%secim%"=="3" goto list_ports
if "%secim%"=="4" exit
echo.
echo   [!] Hatalı seçim, tekrar deneyin.
timeout /t 1 >nul
goto menu

:list_ports
cls
echo.
echo   ╔══════════════════════════════════════════════════════════════════════╗
echo   ║                    DİNLEME YAPAN TÜM PORTLAR                         ║
echo   ╚══════════════════════════════════════════════════════════════════════╝
echo.
echo    Proto   Yerel Adres                    PID
echo    ─────   ───────────                    ───
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
echo   ║                          PORTU YOK ET                                ║
echo   ╚══════════════════════════════════════════════════════════════════════╝
echo.
set "port="
set /p port="  » Yok edilecek PORT numarasını girin: "
if "%port%"=="" goto menu
echo %port%| findstr /R "^[0-9]*$" >nul 2>&1
if errorlevel 1 (
    echo.
    echo   [✗] Hata: Lütfen sadece rakam girin!
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
    echo   [!!!] UYARI: %port% portu sistem için kritiktir!
    echo   [!!!] Bu işlem güvenlik nedeniyle engellendi.
    echo.
    pause
    goto menu
)

echo.
echo   [~] %port% portu taranıyor...

set "pid="
for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":%port% " ^| findstr LISTENING') do set pid=%%a

if "%pid%"=="" (
    echo.
    echo   [✗] %port% portunu kullanan aktif bir süreç bulunamadı.
    echo.
    pause
    goto menu
)

set "pname=Bilinmiyor"
for /f "tokens=1" %%n in ('tasklist /FI "PID eq %pid%" /NH /FO CSV 2^>nul ^| findstr /v "bilgi"') do (
    set "pname=%%~n"
)

echo   [✓] Tespit Edilen PID  : %pid%
echo   [✓] İşlem Adı          : %pname%
echo.
echo   [~] Sonlandırılıyor...

taskkill /F /PID %pid% >nul 2>&1
echo.
echo   [✓] %port% portu başarıyla temizlendi! PID: %pid%

echo.
pause
goto menu

:query_port
cls
echo.
echo   ╔══════════════════════════════════════════════════════════════════════╗
echo   ║                         PORTU SORGULA                                ║
echo   ╚══════════════════════════════════════════════════════════════════════╝
echo.
set "port="
set /p port="  » Sorgulanacak PORT numarasını girin: "
if "%port%"=="" goto menu
echo %port%| findstr /R "^[0-9]*$" >nul 2>&1
if errorlevel 1 (
    echo.
    echo   [✗] Hata: Lütfen sadece rakam girin!
    echo.
    pause
    goto menu
)

echo.
echo   [~] %port% portu taranıyor...

set "pid="
for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":%port% " ^| findstr LISTENING') do set pid=%%a

if "%pid%"=="" (
    echo.
    echo   [✗] %port% portunu kullanan aktif bir süreç bulunamadı.
    echo.
    pause
    goto menu
)

set "pname=Bilinmiyor"
for /f "tokens=1" %%n in ('tasklist /FI "PID eq %pid%" /NH /FO CSV 2^>nul ^| findstr /v "bilgi"') do (
    set "pname=%%~n"
)

echo   [✓] Port              : %port%
echo   [✓] PID               : %pid%
echo   [✓] İşlem Adı          : %pname%
echo.
pause
goto menu
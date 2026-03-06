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
title Sistem Temizleyici V1.1
color 0B
mode con cols=90 lines=40

:menu
cls
echo.
echo   ██████╗██╗     ███████╗ █████╗ ███╗   ██╗███████╗██████╗
echo  ██╔════╝██║     ██╔════╝██╔══██╗████╗  ██║██╔════╝██╔══██╗
echo  ██║     ██║     █████╗  ███████║██╔██╗ ██║█████╗  ██████╔╝
echo  ██║     ██║     ██╔══╝  ██╔══██║██║╚██╗██║██╔══╝  ██╔══██╗
echo  ╚██████╗███████╗███████╗██║  ██║██║ ╚████║███████╗██║  ██║
echo   ╚═════╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝
echo.
echo     ╔══════════════════════════════════════════════════════════════════════╗
echo     ║          SİSTEM TEMİZLEME ARACI ^| BY YUSUFEREN97                     ║
echo     ╚══════════════════════════════════════════════════════════════════════╝
echo.
echo    [1] Hızlı Temizlik
echo    [2] Detaylı Temizlik
echo    [3] Özel Temizlik
echo    [4] Çıkış
echo.
echo    Hızlı  : Temp, Prefetch, Çöp Kutusu, DNS
echo    Detaylı: Tüm alanlar temizlenir
echo    Özel   : İstediğiniz alanları seçersiniz
echo.
set /p secim="  » Seçiminizi yapın (1-4): "

if "%secim%"=="1" goto hizli
if "%secim%"=="2" goto detayli
if "%secim%"=="3" goto ozel
if "%secim%"=="4" exit
echo.
echo   [!] Hatalı seçim, tekrar deneyin.
timeout /t 1 >nul
goto menu

:hizli
cls
echo.
echo   ╔══════════════════════════════════════════════════════════════════════╗
echo   ║                     HIZLI TEMİZLİK BAŞLATILDI                        ║
echo   ╚══════════════════════════════════════════════════════════════════════╝
echo.

call :clean_user_temp
call :clean_win_temp
call :clean_prefetch
call :clean_recycle
call :clean_dns

goto bitti

:detayli
cls
echo.
echo   ╔══════════════════════════════════════════════════════════════════════╗
echo   ║                    DETAYLI TEMİZLİK BAŞLATILDI                       ║
echo   ╚══════════════════════════════════════════════════════════════════════╝
echo.

call :clean_user_temp
call :clean_win_temp
call :clean_prefetch
call :clean_recycle
call :clean_dns
call :clean_wer
call :clean_logs

goto bitti

:ozel
cls
echo.
echo   ╔══════════════════════════════════════════════════════════════════════╗
echo   ║                      ÖZEL TEMİZLİK SEÇİMİ                            ║
echo   ╚══════════════════════════════════════════════════════════════════════╝
echo.
echo    [1] User Temp
echo    [2] Windows Temp
echo    [3] Prefetch
echo    [4] Çöp Kutusu
echo    [5] DNS Önbelleği
echo    [6] Hata Raporları (WER)
echo    [7] Sistem Logları
echo.
echo    Birden fazla seçim yapabilirsiniz (boşlukla ayırın)
echo    Örnek: 1 3 5
echo.
set /p ozel_secim="  » Seçiminiz: "

cls
echo.
echo   ╔══════════════════════════════════════════════════════════════════════╗
echo   ║                     ÖZEL TEMİZLİK BAŞLATILDI                         ║
echo   ╚══════════════════════════════════════════════════════════════════════╝
echo.

for %%i in (%ozel_secim%) do (
    if "%%i"=="1" call :clean_user_temp
    if "%%i"=="2" call :clean_win_temp
    if "%%i"=="3" call :clean_prefetch
    if "%%i"=="4" call :clean_recycle
    if "%%i"=="5" call :clean_dns
    if "%%i"=="6" call :clean_wer
    if "%%i"=="7" call :clean_logs
)

goto bitti

:bitti
echo.
echo   ╔══════════════════════════════════════════════════════════════════════╗
echo   ║                  TEMİZLİK BAŞARIYLA TAMAMLANDI!                      ║
echo   ╚══════════════════════════════════════════════════════════════════════╝
echo.
echo   Menüye dönmek için bir tuşa basın...
pause >nul
goto menu


:clean_user_temp
echo   [+] User Temp temizleniyor...
for %%f in ("%temp%\*.*") do (
    if not "%%~ff"=="%~f0" del /q /f "%%f" >nul 2>&1
)
for /d %%x in ("%temp%\*") do (
    if not "%%~fx"=="%~dp0" rd /s /q "%%x" >nul 2>&1
)
goto :eof

:clean_win_temp
echo   [+] Windows Temp temizleniyor...
del /q /s /f "C:\Windows\Temp\*.*" >nul 2>&1
for /d %%x in ("C:\Windows\Temp\*") do rd /s /q "%%x" >nul 2>&1
goto :eof

:clean_prefetch
echo   [+] Prefetch temizleniyor...
del /q /s /f "C:\Windows\Prefetch\*.*" >nul 2>&1
goto :eof

:clean_recycle
echo   [+] Çöp kutusu boşaltılıyor...
for %%d in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\$Recycle.Bin" rd /s /q "%%d:\$Recycle.Bin" >nul 2>&1
)
goto :eof

:clean_dns
echo   [+] DNS önbelleği temizleniyor...
ipconfig /flushdns >nul 2>&1
goto :eof

:clean_wer
echo   [+] Hata raporları (WER) temizleniyor...
if exist "C:\ProgramData\Microsoft\Windows\WER" (
    del /q /s /f "C:\ProgramData\Microsoft\Windows\WER\*.*" >nul 2>&1
    for /d %%x in ("C:\ProgramData\Microsoft\Windows\WER\*") do rd /s /q "%%x" >nul 2>&1
)
goto :eof

:clean_logs
echo   [+] Sistem logları temizleniyor...
del /q /s /f "C:\Windows\*.log" >nul 2>&1
goto :eof
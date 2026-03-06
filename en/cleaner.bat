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
title System Cleaner V1.1
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
echo     ║          SYSTEM CLEANING TOOL ^| BY YUSUFEREN97                       ║
echo     ╚══════════════════════════════════════════════════════════════════════╝
echo.
echo    [1] Quick Clean
echo    [2] Deep Clean
echo    [3] Custom Clean
echo    [4] Exit
echo.
echo    Quick  : Temp, Prefetch, Recycle Bin, DNS
echo    Deep   : All areas will be cleaned
echo    Custom : Choose which areas to clean
echo.
set /p choice="  » Make your choice (1-4): "

if "%choice%"=="1" goto quick
if "%choice%"=="2" goto deep
if "%choice%"=="3" goto custom
if "%choice%"=="4" exit
echo.
echo   [!] Invalid choice, please try again.
timeout /t 1 >nul
goto menu

:quick
cls
echo.
echo   ╔══════════════════════════════════════════════════════════════════════╗
echo   ║                      QUICK CLEAN STARTED                             ║
echo   ╚══════════════════════════════════════════════════════════════════════╝
echo.

call :clean_user_temp
call :clean_win_temp
call :clean_prefetch
call :clean_recycle
call :clean_dns

goto done

:deep
cls
echo.
echo   ╔══════════════════════════════════════════════════════════════════════╗
echo   ║                      DEEP CLEAN STARTED                              ║
echo   ╚══════════════════════════════════════════════════════════════════════╝
echo.

call :clean_user_temp
call :clean_win_temp
call :clean_prefetch
call :clean_recycle
call :clean_dns
call :clean_wer
call :clean_logs

goto done

:custom
cls
echo.
echo   ╔══════════════════════════════════════════════════════════════════════╗
echo   ║                      CUSTOM CLEAN SELECTION                          ║
echo   ╚══════════════════════════════════════════════════════════════════════╝
echo.
echo    [1] User Temp
echo    [2] Windows Temp
echo    [3] Prefetch
echo    [4] Recycle Bin
echo    [5] DNS Cache
echo    [6] Error Reports (WER)
echo    [7] System Logs
echo.
echo    You can select multiple options (separate with spaces)
echo    Example: 1 3 5
echo.
set /p custom_choice="  » Your selection: "

cls
echo.
echo   ╔══════════════════════════════════════════════════════════════════════╗
echo   ║                      CUSTOM CLEAN STARTED                            ║
echo   ╚══════════════════════════════════════════════════════════════════════╝
echo.

for %%i in (%custom_choice%) do (
    if "%%i"=="1" call :clean_user_temp
    if "%%i"=="2" call :clean_win_temp
    if "%%i"=="3" call :clean_prefetch
    if "%%i"=="4" call :clean_recycle
    if "%%i"=="5" call :clean_dns
    if "%%i"=="6" call :clean_wer
    if "%%i"=="7" call :clean_logs
)

goto done

:done
echo.
echo   ╔══════════════════════════════════════════════════════════════════════╗
echo   ║                   CLEANUP COMPLETED SUCCESSFULLY!                    ║
echo   ╚══════════════════════════════════════════════════════════════════════╝
echo.
echo   Press any key to return to menu...
pause >nul
goto menu


:clean_user_temp
echo   [+] Cleaning User Temp...
for %%f in ("%temp%\*.*") do (
    if not "%%~ff"=="%~f0" del /q /f "%%f" >nul 2>&1
)
for /d %%x in ("%temp%\*") do (
    if not "%%~fx"=="%~dp0" rd /s /q "%%x" >nul 2>&1
)
goto :eof

:clean_win_temp
echo   [+] Cleaning Windows Temp...
del /q /s /f "C:\Windows\Temp\*.*" >nul 2>&1
for /d %%x in ("C:\Windows\Temp\*") do rd /s /q "%%x" >nul 2>&1
goto :eof

:clean_prefetch
echo   [+] Cleaning Prefetch...
del /q /s /f "C:\Windows\Prefetch\*.*" >nul 2>&1
goto :eof

:clean_recycle
echo   [+] Emptying Recycle Bin...
for %%d in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\$Recycle.Bin" rd /s /q "%%d:\$Recycle.Bin" >nul 2>&1
)
goto :eof

:clean_dns
echo   [+] Flushing DNS cache...
ipconfig /flushdns >nul 2>&1
goto :eof

:clean_wer
echo   [+] Cleaning Error Reports (WER)...
if exist "C:\ProgramData\Microsoft\Windows\WER" (
    del /q /s /f "C:\ProgramData\Microsoft\Windows\WER\*.*" >nul 2>&1
    for /d %%x in ("C:\ProgramData\Microsoft\Windows\WER\*") do rd /s /q "%%x" >nul 2>&1
)
goto :eof

:clean_logs
echo   [+] Cleaning System Logs...
del /q /s /f "C:\Windows\*.log" >nul 2>&1
goto :eof

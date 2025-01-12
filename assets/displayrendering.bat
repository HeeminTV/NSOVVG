@echo off
setlocal enabledelayedexpansion 
CHCP 65001 
title Rendering... 
mode 54,8 
for /f "tokens=* delims=" %%a in ('ffprobe -v error -show_entries format^=duration -of default^=noprint_wrappers^=1:nokey^=1 "%~1"') do ( 
    set decimal_value=%%a 
) 
for /f "usebackq tokens=* delims=" %%a in (`powershell -command "[math]::Round(%decimal_value% * 1000)"`) do ( 
	set duration=%%a 
) 
:a 
if not exist "%~2" goto a 
set /p ifnone=<"%~2" 
if "!ifnone!"=="None" exit /b 
set "result=" 
for /f "tokens=2 delims==" %%a in ('findstr "out_time_ms" "%~2"') do ( 
    set /a last_out_time=%%a / 1000 
) 
if not defined last_out_time goto a 
set /a percent=(last_out_time*100)/duration 2>nul 
set /a display=(last_out_time*50)/duration 2>nul 
for /l %%i in (1,1,!display!) do set "result=!result![103m [0m" 
set /a remaining=50-!display! 
for /l %%i in (1,1,!remaining!) do set "result=!result![44m [0m" 
if not defined result goto a 
cls 
echo. 
echo [44m[97m [7mO==================================================O[27m 
echo     Not Serious Oscilloscope View Video Generator    
echo     Rendering: !percent!%%				     
echo.                                                      
echo  !result![44m[97m  
echo  [7mO==================================================O[27m 
timeout 1 > nul 
goto a 

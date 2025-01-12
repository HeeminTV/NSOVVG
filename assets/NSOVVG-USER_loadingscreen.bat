@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
CHCP 65001
TITLE NSOVVG
set i=0
set introy=2
set "gap=				"
set "loadign=[4A	%~2"
CLS

call :INTRO

:EXI
cls
CALL :DRLOGO

ECHO.
ECHO.
ECHO.
ECHO.
:TEST
set /a i+=1

CALL :ANI!i!
if !i! GEQ 4 set i=0
timeout 0 >nul
IF NOT EXIST "%~1" ( 
	CALL :OUTRO
	EXIT /B
)
GOTO TEST

:ANI1
echo !loadign!   
ECHO !gap!   / 
ECHO !gap!  /  
ECHO !gap! /   
GOTO :EOF

:ANI2
echo !loadign!.  
ECHO !gap!  ^|  
ECHO !gap!  ^|  
ECHO !gap!  ^|  
GOTO :EOF

:ANI3
echo !loadign!.. 	
ECHO !gap! \   
ECHO !gap!  \  
ECHO !gap!   \ 
GOTO :EOF

:ANI4
echo !loadign!...
ECHO !gap!ㅤㅤㅤㅤㅤ
ECHO !gap!-----
ECHO !gap!ㅤㅤㅤㅤㅤ
GOTO :EOF

:ANI_ALT1
echo !loadign!   
ECHO !gap!╔───┐
ECHO !gap!│   │
ECHO !gap!└───╝
GOTO :EOF

:ANI_ALT2
echo !loadign!   
ECHO !gap!┌═──┐
ECHO !gap!│   │
ECHO !gap!└──═┘
GOTO :EOF

:ANI_ALT3
echo !loadign!   
ECHO !gap!┌─═─┐
ECHO !gap!│   │
ECHO !gap!└─═─┘
GOTO :EOF

:ANI_ALT4
echo !loadign!   
ECHO !gap!┌──═┐
ECHO !gap!│   │
ECHO !gap!└═──┘
GOTO :EOF

:ANI_ALT5
echo !loadign!   
ECHO !gap!┌───╗
ECHO !gap!│   │
ECHO !gap!╚───┘
GOTO :EOF

:ANI_ALT6
echo !loadign!   
ECHO !gap!┌───┐
ECHO !gap!║   ║
ECHO !gap!└───┘
GOTO :EOF

:DRLOGO
ECHO.
echo    [1m[97m         ,--.              ,----..
echo           ,--.'^| .--.--.     /   /   \                         ,----..
echo       ,--,:  : ^|/  /    '.  /   .     :       ,---.      ,---./   /   \
echo    ,`--.'`^|  ' ^|  :  /`. / .   /   ;.  \     /__./^|     /__./^|   :     :
echo    ^|   :  :  ^| ;  ^|  ^|--` .   ;   /  ` ;,---.;  ; ^|,---.;  ; .   ^|  ;. /
echo    :   ^|   \ ^| ^|  :  ;_   ;   ^|  ; \ ; /___/ \  ^| /___/ \  ^| .   ; /--`
echo    ^|   : '  '; ^|\  \    `.^|   :  ^| ; ^| \   ;  \ ' \   ;  \ ' ;   ^| ;  __
echo    '   ' ;.    ; `----.   .   ^|  ' ' ' :\   \  \: ^|\   \  \: ^|   : ^|.' .'
echo    ^|   ^| ^| \   ^| __ \  \  '   ;  \; /  ^| ;   \  ' . ;   \  ' .   ^| '_.' :
echo    '   : ^|  ; .'/  /`--'  /\   \  ',  /   \   \   '  \   \   '   ; : \  ^|
echo    ^|   ^| '`--' '--'.     /  ;   :    /     \   `  ;   \   `  '   ^| '/  .'
echo    '   : ^|       `--'---'    \   \ .'       :   \ ^|    :   \ ^|   :    /
echo    ;   ^|.'                    `---`          '---"      '---" \   \ .'
echo    '---'                                                       `---`[0m
echo.             Not Serious Oscilloscope View Video Generator
echo.
GOTO :EOF

:INTRO
set /a introy+=1
MODE 75, !introy!
CALL :DRLOGO
if !introy! GEQ 23  goto :EOF
GOTO INTRO

:OUTRO
set /a introy-=1
MODE 75, !introy!
CALL :DRLOGO
if !introy! LSS 2  goto :EOF
GOTO OUTRO
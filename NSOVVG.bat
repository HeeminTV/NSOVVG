@echo    OFF

SETLOCAL ENABLEDELAYEDEXPANSION
title Not Serious Oscilloscope View Video Generator - by heeminwelcome1@gmail.com
"%__APPDIR__%chcp.com" 949 >nul
rem set found=0



:resetvariables
:: VERSION
SET "NSOVVGVERSION=1.0.4a6"

set "masteraudio=None"
set "bgimage=None"
set x_res=1280
set y_res=720
set "fps=60"
set "bitrate=5000k"
set "linemode=p2p"
set "chosenfiles="
set "tempfileprefix=!temp!\NSOVVG_"
set "userfileprefix=!temp!\NSOVVG-USER_"

set "progressbartestpath=!tempfileprefix!displayrendering.bat"
set "progresslogpath=!tempfileprefix!ffmpegprogresslog.log"
set "fontpickerpath=!tempfileprefix!fontPicker.ps1"
set "numberboxpath=!tempfileprefix!numberBox.ps1"
set "reorderboxpath=!tempfileprefix!reorder.ps1"
set "colorpickerpath=!tempfileprefix!colorPicker.ps1"
set "ffmpeglogpath=!tempfileprefix!ffmpeglog.log"
set "ffmpegrenderingerrorboxpath=!tempfileprefix!ffmpegrenderingerrorBox.ps1"
set "chsortboxpath=!tempfileprefix!chsortBox.ps1"
set "loadingshowname=!userfileprefix!loading"

del /q "!tempfileprefix!*" 2>nul

if not exist "!loadingshowname!.bat" (
	ECHO Please wait a moment... This procedure will be run once on the first run...
	echo QEVDSE8gT0ZGDQpTRVRMT0NBTCBFTkFCTEVERUxBWUVERVhQQU5TSU9ODQpDSENQIDY1MDAxDQpUSVRMRSAlfjINCnNldCBpPTANCnNldCBpbnRyb3k9Mg0Kc2V0ICJnYXA9CQkJCSINCnNldCAibG9hZGlnbj0bWzRBCUxvYWRpbmciDQpDTFMNCg0KY2FsbCA6SU5UUk8NCg0KOkVYSQ0KY2xzDQpDQUxMIDpEUkxPR08NCg0KRUNITy4NCkVDSE8uDQpFQ0hPLg0KRUNITy4NCjpURVNUDQpzZXQgL2EgaSs9MQ0KDQpDQUxMIDpBTkkhaSENCmlmICFpISBHRVEgNCBzZXQgaT0wDQp0aW1lb3V0IDAgPm51bA0KSUYgTk9UIEVYSVNUICIlfjEiICggDQoJQ0FMTCA6T1VUUk8NCglFWElUIC9CDQopDQpHT1RPIFRFU1QNCg0KOkFOSTENCmVjaG8gIWxvYWRpZ24hICAgDQpFQ0hPICFnYXAhICAgLyANCkVDSE8gIWdhcCEgIC8gIA0KRUNITyAhZ2FwISAvICAgDQpHT1RPIDpFT0YNCg0KOkFOSTINCmVjaG8gIWxvYWRpZ24hLiAgDQpFQ0hPICFnYXAhICBefCAgDQpFQ0hPICFnYXAhICBefCAgDQpFQ0hPICFnYXAhICBefCAgDQpHT1RPIDpFT0YNCg0KOkFOSTMNCmVjaG8gIWxvYWRpZ24hLi4gCQ0KRUNITyAhZ2FwISBcICAgDQpFQ0hPICFnYXAhICBcICANCkVDSE8gIWdhcCEgICBcIA0KR09UTyA6RU9GDQoNCjpBTkk0DQplY2hvICFsb2FkaWduIS4uLg0KRUNITyAhZ2FwIeOFpOOFpOOFpOOFpOOFpA0KRUNITyAhZ2FwIS0tLS0tDQpFQ0hPICFnYXAh44Wk44Wk44Wk44Wk44WkDQpHT1RPIDpFT0YNCg0KOkFOSV9BTFQxDQplY2hvICFsb2FkaWduISAgIA0KRUNITyAhZ2FwIeKVlOKUgOKUgOKUgOKUkA0KRUNITyAhZ2FwIeKUgiAgIOKUgg0KRUNITyAhZ2FwIeKUlOKUgOKUgOKUgOKVnQ0KR09UTyA6RU9GDQoNCjpBTklfQUxUMg0KZWNobyAhbG9hZGlnbiEgICANCkVDSE8gIWdhcCHilIzilZDilIDilIDilJANCkVDSE8gIWdhcCHilIIgICDilIINCkVDSE8gIWdhcCHilJTilIDilIDilZDilJgNCkdPVE8gOkVPRg0KDQo6QU5JX0FMVDMNCmVjaG8gIWxvYWRpZ24hICAgDQpFQ0hPICFnYXAh4pSM4pSA4pWQ4pSA4pSQDQpFQ0hPICFnYXAh4pSCICAg4pSCDQpFQ0hPICFnYXAh4pSU4pSA4pWQ4pSA4pSYDQpHT1RPIDpFT0YNCg0KOkFOSV9BTFQ0DQplY2hvICFsb2FkaWduISAgIA0KRUNITyAhZ2FwIeKUjOKUgOKUgOKVkOKUkA0KRUNITyAhZ2FwIeKUgiAgIOKUgg0KRUNITyAhZ2FwIeKUlOKVkOKUgOKUgOKUmA0KR09UTyA6RU9GDQoNCjpBTklfQUxUNQ0KZWNobyAhbG9hZGlnbiEgICANCkVDSE8gIWdhcCHilIzilIDilIDilIDilZcNCkVDSE8gIWdhcCHilIIgICDilIINCkVDSE8gIWdhcCHilZrilIDilIDilIDilJgNCkdPVE8gOkVPRg0KDQo6QU5JX0FMVDYNCmVjaG8gIWxvYWRpZ24hICAgDQpFQ0hPICFnYXAh4pSM4pSA4pSA4pSA4pSQDQpFQ0hPICFnYXAh4pWRICAg4pWRDQpFQ0hPICFnYXAh4pSU4pSA4pSA4pSA4pSYDQpHT1RPIDpFT0YNCg0KOkRSTE9HTw0KRUNITy4NCmVjaG8gICAgG1sxbRtbOTdtICAgICAgICAgLC0tLiAgICAgICAgICAgICAgLC0tLS0uLg0KZWNobyAgICAgICAgICAgLC0tLidefCAuLS0uLS0uICAgICAvICAgLyAgIFwgICAgICAgICAgICAgICAgICAgICAgICAgLC0tLS0uLiAgICAJDQplY2hvICAgICAgICwtLSw6ICA6IF58LyAgLyAgICAnLiAgLyAgIC4gICAgIDogICAgICAgLC0tLS4gICAgICAsLS0tLi8gICAvICAgXCAgIAkNCmVjaG8gICAgLGAtLS4nYF58ICAnIF58ICA6ICAvYC4gLyAuICAgLyAgIDsuICBcICAgICAvX18uL158ICAgICAvX18uL158ICAgOiAgICAgOiAgCQ0KZWNobyAgICBefCAgIDogIDogIF58IDsgIF58ICBefC0tYCAuICAgOyAgIC8gIGAgOywtLS0uOyAgOyBefCwtLS0uOyAgOyAuICAgXnwgIDsuIC8gIAkNCmVjaG8gICAgOiAgIF58ICAgXCBefCBefCAgOiAgO18gICA7ICAgXnwgIDsgXCA7IC9fX18vIFwgIF58IC9fX18vIFwgIF58IC4gICA7IC8tLWAgICAJDQplY2hvICAgIF58ICAgOiAnICAnOyBefFwgIFwgICAgYC5efCAgIDogIF58IDsgXnwgXCAgIDsgIFwgJyBcICAgOyAgXCAnIDsgICBefCA7ICBfXyAgCQ0KZWNobyAgICAnICAgJyA7LiAgICA7IGAtLS0tLiAgIC4gICBefCAgJyAnICcgOlwgICBcICBcOiBefFwgICBcICBcOiBefCAgIDogXnwuJyAuJyAJDQplY2hvICAgIF58ICAgXnwgXnwgXCAgIF58IF9fIFwgIFwgICcgICA7ICBcOyAvICBefCA7ICAgXCAgJyAuIDsgICBcICAnIC4gICBefCAnXy4nIDogCQ0KZWNobyAgICAnICAgOiBefCAgOyAuJy8gIC9gLS0nICAvXCAgIFwgICcsICAvICAgXCAgIFwgICAnICBcICAgXCAgICcgICA7IDogXCAgXnwgCQ0KZWNobyAgICBefCAgIF58ICdgLS0nICctLScuICAgICAvICA7ICAgOiAgICAvICAgICBcICAgYCAgOyAgIFwgICBgICAnICAgXnwgJy8gIC4nIAkNCmVjaG8gICAgJyAgIDogXnwgICAgICAgYC0tJy0tLScgICAgXCAgIFwgLicgICAgICAgOiAgIFwgXnwgICAgOiAgIFwgXnwgICA6ICAgIC8gICAJDQplY2hvICAgIDsgICBefC4nICAgICAgICAgICAgICAgICAgICBgLS0tYCAgICAgICAgICAnLS0tIiAgICAgICctLS0iIFwgICBcIC4nDQplY2hvICAgICctLS0nICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGAtLS1gICAgICAgG1swbQ0KZWNoby4gICAgICAgICAgICAgTm90IFNlcmlvdXMgT3NjaWxsb3Njb3BlIFZpZXcgVmlkZW8gR2VuZXJhdG9yDQplY2hvLg0KR09UTyA6RU9GDQoNCjpJTlRSTw0Kc2V0IC9hIGludHJveSs9MQ0KTU9ERSA3NSwgIWludHJveSENCkNBTEwgOkRSTE9HTw0KaWYgIWludHJveSEgR0VRIDIzICBnb3RvIDpFT0YNCkdPVE8gSU5UUk8NCg0KOk9VVFJPDQpzZXQgL2EgaW50cm95LT0xDQpNT0RFIDc1LCAhaW50cm95IQ0KQ0FMTCA6RFJMT0dPDQppZiAhaW50cm95ISBMU1MgMiAgZ290byA6RU9GDQpHT1RPIE9VVFJP > "!loadingshowname!.b64"
	certutil -decode "!loadingshowname!.b64" "!loadingshowname!.bat" >nul
) else echo. > "!loadingshowname!.b64"
START conhost "!loadingshowname!.bat" "!loadingshowname!.b64" "NSOVVG"

set "dffont=Arial"
set "h1count="
set "h2count="
rem set "displayfont=Arial                  "
set "sizefont=14"
set "colorfont=#FFFFFF"
set "chsort=4=4"

echo Checking for the existence of the ffmpeg set... Please wait!
set fmpeg=0
set fplay=0
set fprobe=0

IF EXIST "ffmpeg.exe" ( set "fmpeg=1" ) else for %%P in (!PATH!) do (
        IF EXIST "%%~P\ffmpeg.exe" set "fmpeg=1"
)
		
IF EXIST "ffplay.exe" ( set "fplay=1" ) else for %%P in (!PATH!) do (
        IF EXIST "%%~P\ffplay.exe" set "fplay=1"
)
IF EXIST "ffprobe.exe" ( set "fprobe=1" ) else for %%P in (!PATH!) do (
        IF EXIST "%%~P\ffprobe.exe" set "fprobe=1"
)

if "!fmpeg!!fplay!!fprobe!" NEQ "111" call :errmsg "Some or all of the ffmpeg set is missing. Please put the set in the same directory as this script or system path"

echo Detecting your GPU... Please wait!
call :gpudetect
echo Creating external scripts... Please wait!


:bfdrawlogo

 echo @echo off> !progressbartestpath!
 echo setlocal enabledelayedexpansion >> !progressbartestpath!
 echo title Rendering... >> !progressbartestpath!
 echo mode 53,8 >> !progressbartestpath!
 echo for /f "tokens=* delims=" %%%%a in ('ffprobe -v error -show_entries format^^=duration -of default^^=noprint_wrappers^^=1:nokey^^=1 "%%~1"') do ( >> !progressbartestpath!
 echo     set decimal_value=%%%%a >> !progressbartestpath!
 echo ) >> !progressbartestpath!
 echo for /f "usebackq tokens=* delims=" %%%%a in (`powershell -command "[math]::Round(%%decimal_value%% * 1000)"`) do ( >> !progressbartestpath!
 echo 	set duration=%%%%a >> !progressbartestpath!
 echo ) >> !progressbartestpath!
 echo :a >> !progressbartestpath!
 echo if not exist "%%~2" goto a >> !progressbartestpath!
 echo set /p ifnone=^<"%%~2" >> !progressbartestpath!
 echo if "^!ifnone^!"=="None" exit /b >> !progressbartestpath!
 echo set "result=" >> !progressbartestpath!
 echo for /f "tokens=2 delims==" %%%%a in ('findstr "out_time_ms" "%%~2"') do ( >> !progressbartestpath!
 echo     set /a last_out_time=%%%%a / 1000 >> !progressbartestpath!
 echo ) >> !progressbartestpath!
 echo if not defined last_out_time goto a >> !progressbartestpath!
 echo set /a percent=(last_out_time*100)/duration >> !progressbartestpath!
 echo set /a display=(last_out_time*50)/duration >> !progressbartestpath!
 echo for /l %%%%i in (1,1,^^!display^^!) do set "result=^!result^![103m [0m" >> !progressbartestpath!
 echo set /a remaining=50-^^!display^^! >> !progressbartestpath!
 echo for /l %%%%i in (1,1,^^!remaining^^!) do set "result=^!result^![44m [0m" >> !progressbartestpath!
 echo if not defined result goto a >> !progressbartestpath!
 echo cls >> !progressbartestpath!
 echo echo [44m[97m¦®¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¯ >> !progressbartestpath!
 echo echo ¦­   Not Serious Oscilloscope View Video Generator  ¦­ >> !progressbartestpath!
 echo echo ¦­   Rendering: ^^!percent^^!%%%%				   ¦­ >> !progressbartestpath!
 echo echo ¦­                                                  ¦­ >> !progressbartestpath!
 echo echo ¦­^^!result^^![44m[97m¦­ >> !progressbartestpath!
 echo echo ¦±¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦° >> !progressbartestpath!
 echo echo To abort, press [7m[Ctrl][27m + [7m[C][27m on the main console. >> !progressbartestpath!
 echo timeout 1 ^> nul >> !progressbartestpath!
 echo goto a >> !progressbartestpath!
 
echo Add-Type -AssemblyName System.Windows.Forms > !reorderboxpath!
echo Add-Type -AssemblyName System.Drawing >> !reorderboxpath!


echo $channels = @^(^) >> !reorderboxpath!
echo for ^($i = 1; $true; $i++^) { >> !reorderboxpath!
echo     $varName = "channel$i" >> !reorderboxpath!
echo     $value = [Environment]::GetEnvironmentVariable^($varName^) >> !reorderboxpath!
echo     if ^($null -eq $value^) { break } >> !reorderboxpath!
echo     $channels += $value >> !reorderboxpath!
echo } >> !reorderboxpath!


echo $form = New-Object System.Windows.Forms.Form >> !reorderboxpath!
echo $form.Text = "Reorder Channels" >> !reorderboxpath!
echo $form.Width = 800 >> !reorderboxpath!
echo $form.Height = 300 >> !reorderboxpath!
echo $form.StartPosition = 'CenterScreen' >> !reorderboxpath!


echo $listBox = New-Object System.Windows.Forms.ListBox >> !reorderboxpath!
echo $listBox.Location = New-Object System.Drawing.Point^(10, 10^) >> !reorderboxpath!
echo $listBox.Size = New-Object System.Drawing.Size^(700, 200^) >> !reorderboxpath!
echo $listBox.SelectionMode = 'One' >> !reorderboxpath!
echo $listBox.Items.AddRange^($channels^) >> !reorderboxpath!
echo $form.Controls.Add^($listBox^) >> !reorderboxpath!


echo $btnUp = New-Object System.Windows.Forms.Button >> !reorderboxpath!
echo $btnUp.Text = "Up" >> !reorderboxpath!
echo $btnUp.Location = New-Object System.Drawing.Point^(710, 30^) >> !reorderboxpath!
echo $btnUp.Add_Click^({ >> !reorderboxpath!
echo     $selectedIndex = $listBox.SelectedIndex >> !reorderboxpath!
echo     if ^($selectedIndex -gt 0^) { >> !reorderboxpath!

echo         $temp = $listBox.Items[$selectedIndex] >> !reorderboxpath!
echo         $listBox.Items[$selectedIndex] = $listBox.Items[$selectedIndex - 1] >> !reorderboxpath!
echo         $listBox.Items[$selectedIndex - 1] = $temp >> !reorderboxpath!
echo         $listBox.SelectedIndex = $selectedIndex - 1 >> !reorderboxpath!
echo     } >> !reorderboxpath!
echo }^) >> !reorderboxpath!
echo $form.Controls.Add^($btnUp^) >> !reorderboxpath!


echo $btnDown = New-Object System.Windows.Forms.Button >> !reorderboxpath!
echo $btnDown.Text = "Down" >> !reorderboxpath!
echo $btnDown.Location = New-Object System.Drawing.Point^(710, 70^) >> !reorderboxpath!
echo $btnDown.Add_Click^({ >> !reorderboxpath!
echo     $selectedIndex = $listBox.SelectedIndex >> !reorderboxpath!
echo     if ^($selectedIndex -lt $listBox.Items.Count - 1^) { >> !reorderboxpath!

echo         $temp = $listBox.Items[$selectedIndex] >> !reorderboxpath!
echo         $listBox.Items[$selectedIndex] = $listBox.Items[$selectedIndex + 1] >> !reorderboxpath!
echo         $listBox.Items[$selectedIndex + 1] = $temp >> !reorderboxpath!
echo         $listBox.SelectedIndex = $selectedIndex + 1 >> !reorderboxpath!
echo     } >> !reorderboxpath!
echo }^) >> !reorderboxpath!
echo $form.Controls.Add^($btnDown^) >> !reorderboxpath!


echo $btnOK = New-Object System.Windows.Forms.Button >> !reorderboxpath!
echo $btnOK.Text = "OK" >> !reorderboxpath!
echo $btnOK.Location = New-Object System.Drawing.Point^(100, 220^) >> !reorderboxpath!
echo $btnOK.Add_Click^({ >> !reorderboxpath!
echo     $newOrder = $listBox.Items >> !reorderboxpath!

echo foreach ^($channel in $newOrder^) { >> !reorderboxpath!
echo     $index = $channels.IndexOf^($channel^) >> !reorderboxpath!
echo     Write-Host ^($index + 1^) >> !reorderboxpath!
echo } >> !reorderboxpath!

echo     $form.Close^(^) >> !reorderboxpath!
echo }^) >> !reorderboxpath!
echo $form.Controls.Add^($btnOK^) >> !reorderboxpath!


echo $btnCancel = New-Object System.Windows.Forms.Button >> !reorderboxpath!
echo $btnCancel.Text = "Cancel" >> !reorderboxpath!
echo $btnCancel.Location = New-Object System.Drawing.Point^(200, 220^) >> !reorderboxpath!
echo $btnCancel.Add_Click^({ >> !reorderboxpath!
echo     Write-Host "None" >> !reorderboxpath!
echo     $form.Close^(^) >> !reorderboxpath!
echo }^) >> !reorderboxpath!
echo $form.Controls.Add^($btnCancel^) >> !reorderboxpath!


echo $form.Add_Shown^({ $form.Activate^(^) }^) >> !reorderboxpath!
echo [void]$form.ShowDialog^(^) >> !reorderboxpath!

echo param^($defaultColor = "#FF5733"^) > !colorpickerpath!

echo Add-Type -AssemblyName System.Windows.Forms >> !colorpickerpath!


echo function Convert-HexToColor^($hex^) { >> !colorpickerpath!
echo     $r = [Convert]::ToInt32^($hex.Substring^(1, 2^), 16^) >> !colorpickerpath!
echo     $g = [Convert]::ToInt32^($hex.Substring^(3, 2^), 16^) >> !colorpickerpath!
echo     $b = [Convert]::ToInt32^($hex.Substring^(5, 2^), 16^) >> !colorpickerpath!
echo     return [System.Drawing.Color]::FromArgb^($r, $g, $b^) >> !colorpickerpath!
echo } >> !colorpickerpath!


echo $colorDialog = New-Object System.Windows.Forms.ColorDialog >> !colorpickerpath!
echo $colorDialog.FullOpen = $true >> !colorpickerpath!


echo if ^($defaultColor -ne "None"^) { >> !colorpickerpath!
echo     $colorDialog.Color = Convert-HexToColor $defaultColor >> !colorpickerpath!
echo } >> !colorpickerpath!


echo if ^($colorDialog.ShowDialog^(^) -eq [System.Windows.Forms.DialogResult]::OK^) { >> !colorpickerpath!

echo     $color = "#{0:X2}{1:X2}{2:X2}" -f $colorDialog.Color.R, $colorDialog.Color.G, $colorDialog.Color.B >> !colorpickerpath!
echo     Write-Host $color >> !colorpickerpath!
echo } else { >> !colorpickerpath!

echo     Write-Host "None" >> !colorpickerpath!
echo } >> !colorpickerpath!

echo Add-Type -AssemblyName System.Windows.Forms > !ffmpegrenderingerrorboxpath!
echo Add-Type -AssemblyName System.Drawing >> !ffmpegrenderingerrorboxpath!
echo $filePath = "!ffmpeglogpath!" >> !ffmpegrenderingerrorboxpath!
echo $contactText = if ^(Test-Path $filePath^) { >> !ffmpegrenderingerrorboxpath!
echo     $content = Get-Content $filePath -Raw >> !ffmpegrenderingerrorboxpath!
echo     if ^(-not [string]::IsNullOrWhiteSpace^($content^)^) { >> !ffmpegrenderingerrorboxpath!
echo         $content >> !ffmpegrenderingerrorboxpath!
echo     } else { >> !ffmpegrenderingerrorboxpath!
echo         "None" >> !ffmpegrenderingerrorboxpath!
echo     } >> !ffmpegrenderingerrorboxpath!
echo } else { >> !ffmpegrenderingerrorboxpath!
echo     "None" >> !ffmpegrenderingerrorboxpath!
echo } >> !ffmpegrenderingerrorboxpath!


echo $form = New-Object System.Windows.Forms.Form >> !ffmpegrenderingerrorboxpath!
echo $form.Text = "NSOVVG" >> !ffmpegrenderingerrorboxpath!
echo $form.Width = 450 >> !ffmpegrenderingerrorboxpath!
echo $form.Height = 600 >> !ffmpegrenderingerrorboxpath!
echo $form.StartPosition = 'CenterScreen' >> !ffmpegrenderingerrorboxpath!


echo $errorLabel = New-Object System.Windows.Forms.Label >> !ffmpegrenderingerrorboxpath!
echo $errorLabel.Text = "An error occurred during video rendering.`n" + >> !ffmpegrenderingerrorboxpath!
echo                    "To send this error to the developer, click [Save]`n" + >> !ffmpegrenderingerrorboxpath!
echo                    "and send the log file to one of the following contacts:" >> !ffmpegrenderingerrorboxpath!
echo $errorLabel.Location = New-Object System.Drawing.Point^(10, 10^) >> !ffmpegrenderingerrorboxpath!
echo $errorLabel.Size = New-Object System.Drawing.Size^(420, 60^) >> !ffmpegrenderingerrorboxpath!
echo $form.Controls.Add^($errorLabel^) >> !ffmpegrenderingerrorboxpath!


echo $contactBox = New-Object System.Windows.Forms.TextBox >> !ffmpegrenderingerrorboxpath!
echo $contactBox.Multiline = $true >> !ffmpegrenderingerrorboxpath!
echo $contactBox.Text = "Email: heeminwelcome1@gmail.com`r`nDiscord: _yumetaro_" >> !ffmpegrenderingerrorboxpath!
echo $contactBox.Location = New-Object System.Drawing.Point^(10, 80^) >> !ffmpegrenderingerrorboxpath!
echo $contactBox.Size = New-Object System.Drawing.Size^(410, 30^) >> !ffmpegrenderingerrorboxpath!
echo $contactBox.ReadOnly = $true >> !ffmpegrenderingerrorboxpath!
echo $form.Controls.Add^($contactBox^) >> !ffmpegrenderingerrorboxpath!

echo $Banner = New-Object System.Windows.Forms.Label >> !ffmpegrenderingerrorboxpath!
echo $Banner.Text = "Error log:" >> !ffmpegrenderingerrorboxpath!
echo $Banner.Location = New-Object System.Drawing.Point^(10, 115^) >> !ffmpegrenderingerrorboxpath!
echo $Banner.Size = New-Object System.Drawing.Size^(420, 15^) >> !ffmpegrenderingerrorboxpath!
echo $form.Controls.Add^($Banner^) >> !ffmpegrenderingerrorboxpath!

echo $ErrorBox = New-Object System.Windows.Forms.TextBox >> !ffmpegrenderingerrorboxpath!
echo $ErrorBox.Multiline = $true >> !ffmpegrenderingerrorboxpath!
echo $ErrorBox.Text = $contactText >> !ffmpegrenderingerrorboxpath!
echo $ErrorBox.Location = New-Object System.Drawing.Point^(10, 130^) >> !ffmpegrenderingerrorboxpath!
echo $ErrorBox.Size = New-Object System.Drawing.Size^(410, 350^) >> !ffmpegrenderingerrorboxpath!
echo $ErrorBox.ReadOnly = $true >> !ffmpegrenderingerrorboxpath!
echo $form.Controls.Add^($ErrorBox^) >> !ffmpegrenderingerrorboxpath!

echo $saveButton = New-Object System.Windows.Forms.Button >> !ffmpegrenderingerrorboxpath!
echo $saveButton.Text = "Save" >> !ffmpegrenderingerrorboxpath!
echo $saveButton.Location = New-Object System.Drawing.Point^(80, 530^) >> !ffmpegrenderingerrorboxpath!
echo $saveButton.Add_Click^({ >> !ffmpegrenderingerrorboxpath!
echo     Write-Host "YES" >> !ffmpegrenderingerrorboxpath!
echo 	$buttonClicked = $true >> !ffmpegrenderingerrorboxpath!
echo     $form.Close^(^) >> !ffmpegrenderingerrorboxpath!
echo }^) >> !ffmpegrenderingerrorboxpath!
echo $form.Controls.Add^($saveButton^) >> !ffmpegrenderingerrorboxpath!

echo $cancelButton = New-Object System.Windows.Forms.Button >> !ffmpegrenderingerrorboxpath!
echo $cancelButton.Text = "Cancel" >> !ffmpegrenderingerrorboxpath!
echo $cancelButton.Location = New-Object System.Drawing.Point^(240, 530^) >> !ffmpegrenderingerrorboxpath!
echo $cancelButton.Add_Click^({ >> !ffmpegrenderingerrorboxpath!
echo     Write-Host "None" >> !ffmpegrenderingerrorboxpath!
echo 	$buttonClicked = $true >> !ffmpegrenderingerrorboxpath!
echo     $form.Close^(^) >> !ffmpegrenderingerrorboxpath!
echo }^) >> !ffmpegrenderingerrorboxpath!
echo $form.Controls.Add^($cancelButton^) >> !ffmpegrenderingerrorboxpath!

echo $pictureBox = New-Object System.Windows.Forms.PictureBox >> !ffmpegrenderingerrorboxpath!
echo $pictureBox.Size = New-Object System.Drawing.Size^(300, 300^) >> !ffmpegrenderingerrorboxpath!
echo $pictureBox.Location = New-Object System.Drawing.Point^(450, 100^) >> !ffmpegrenderingerrorboxpath!
echo $pictureBox.SizeMode = "Zoom" >> !ffmpegrenderingerrorboxpath!
echo $imageStream = ^(get-item '!tempfileprefix!fjpegify.jpeg'^) >> !ffmpegrenderingerrorboxpath!
echo $pictureBox.Image = [System.Drawing.Image]::Fromfile^($imageStream^) >> !ffmpegrenderingerrorboxpath!
echo $form.Controls.Add^($pictureBox^) >> !ffmpegrenderingerrorboxpath!


echo $form.Add_FormClosing^({ >> !ffmpegrenderingerrorboxpath!
echo     if ^(-not $buttonClicked^) { >> !ffmpegrenderingerrorboxpath!
echo         Write-Host "None" >> !ffmpegrenderingerrorboxpath!
echo     } >> !ffmpegrenderingerrorboxpath!
echo }^) >> !ffmpegrenderingerrorboxpath!
echo $buttonClicked = $false >> !ffmpegrenderingerrorboxpath!
echo $form.Add_Shown^({ $form.Activate^(^) }^) >> !ffmpegrenderingerrorboxpath!
echo [void]$form.ShowDialog^(^) >> !ffmpegrenderingerrorboxpath!

echo Add-Type -AssemblyName System.Windows.Forms >> !chsortboxpath!
echo Add-Type -AssemblyName System.Drawing >> !chsortboxpath!



echo $L = $args[0] >> !chsortboxpath!
echo $R = $args[1] >> !chsortboxpath!
echo $total = $L + $R >> !chsortboxpath!


echo $form = New-Object System.Windows.Forms.Form >> !chsortboxpath!

echo $form.Text = "NSOVVG" >> !chsortboxpath!
echo $form.Size = New-Object System.Drawing.Size^(300, 230^) >> !chsortboxpath!
echo $form.StartPosition = "CenterScreen" >> !chsortboxpath!


echo $labelL = New-Object System.Windows.Forms.Label >> !chsortboxpath!
echo $labelL.Text = "Left Channels:" >> !chsortboxpath!
echo $labelL.Location = New-Object System.Drawing.Point^(10, 20^) >> !chsortboxpath!
echo $labelL.Size = New-Object System.Drawing.Size^(100, 20^) >> !chsortboxpath!
echo $form.Controls.Add^($labelL^) >> !chsortboxpath!

echo $numericL = New-Object System.Windows.Forms.NumericUpDown >> !chsortboxpath!
echo $numericL.Location = New-Object System.Drawing.Point^(120, 20^) >> !chsortboxpath!
echo $numericL.Size = New-Object System.Drawing.Size^(100, 20^) >> !chsortboxpath!
echo $numericL.Minimum = 1 >> !chsortboxpath!
echo $numericL.Maximum = $total - 1 >> !chsortboxpath!
echo $numericL.Value = $L >> !chsortboxpath!
echo $form.Controls.Add^($numericL^) >> !chsortboxpath!


echo $labelR = New-Object System.Windows.Forms.Label >> !chsortboxpath!
echo $labelR.Text = "Right Channels:" >> !chsortboxpath!
echo $labelR.Location = New-Object System.Drawing.Point^(10, 60^) >> !chsortboxpath!
echo $labelR.Size = New-Object System.Drawing.Size^(100, 20^) >> !chsortboxpath!
echo $form.Controls.Add^($labelR^) >> !chsortboxpath!

echo $numericR = New-Object System.Windows.Forms.NumericUpDown >> !chsortboxpath!
echo $numericR.Location = New-Object System.Drawing.Point^(120, 60^) >> !chsortboxpath!
echo $numericR.Size = New-Object System.Drawing.Size^(100, 20^) >> !chsortboxpath!
echo $numericR.Minimum = 1 >> !chsortboxpath!
echo $numericR.Maximum = $total - 1 >> !chsortboxpath!
echo $numericR.Value = $R >> !chsortboxpath!
echo $form.Controls.Add^($numericR^) >> !chsortboxpath!


echo $numericL.add_ValueChanged^({ >> !chsortboxpath!
echo     $numericR.Value = $total - $numericL.Value >> !chsortboxpath!
echo }^) >> !chsortboxpath!


echo $numericR.add_ValueChanged^({ >> !chsortboxpath!
echo     $numericL.Value = $total - $numericR.Value >> !chsortboxpath!
echo }^) >> !chsortboxpath!


echo $btnOK = New-Object System.Windows.Forms.Button >> !chsortboxpath!
echo $btnOK.Text = "OK" >> !chsortboxpath!
echo $btnOK.Location = New-Object System.Drawing.Point^(50, 120^) >> !chsortboxpath!
echo $btnOK.Size = New-Object System.Drawing.Size^(75, 30^) >> !chsortboxpath!
echo $btnOK.Add_Click^({ >> !chsortboxpath!
echo 	$buttonClicked = $true >> !chsortboxpath!
echo     Write-Host "$($numericL.Value)=$($numericR.Value)" >> !chsortboxpath!
echo     $form.Close^(^) >> !chsortboxpath!
echo }^) >> !chsortboxpath!
echo $form.Controls.Add^($btnOK^) >> !chsortboxpath!


echo $btnCancel = New-Object System.Windows.Forms.Button >> !chsortboxpath!
echo $btnCancel.Text = "Cancel" >> !chsortboxpath!
echo $btnCancel.Location = New-Object System.Drawing.Point^(150, 120^) >> !chsortboxpath!
echo $btnCancel.Size = New-Object System.Drawing.Size^(75, 30^) >> !chsortboxpath!
echo $btnCancel.Add_Click^({ >> !chsortboxpath!
echo 	$buttonClicked = $true >> !chsortboxpath!
echo     Write-Host "None" >> !chsortboxpath!
echo     $form.Close^(^) >> !chsortboxpath!
echo }^) >> !chsortboxpath!
echo $form.Controls.Add^($btnCancel^) >> !chsortboxpath!


echo $btnAuto = New-Object System.Windows.Forms.Button >> !chsortboxpath!
echo $btnAuto.Text = "Auto" >> !chsortboxpath!
echo $btnAuto.Location = New-Object System.Drawing.Point^(100, 160^) >> !chsortboxpath!
echo $btnAuto.Size = New-Object System.Drawing.Size^(75, 30^) >> !chsortboxpath!
echo $btnAuto.Add_Click^({ >> !chsortboxpath!
rem echo     
echo     if ^($total %% 2 -eq 0^) { >> !chsortboxpath!
echo         $numericL.Value = $total / 2 >> !chsortboxpath!
echo         $numericR.Value = $total / 2 >> !chsortboxpath!
echo     } else { >> !chsortboxpath!
echo         $numericL.Value = [math]::Ceiling^($total / 2.0^) >> !chsortboxpath!
echo         $numericR.Value = [math]::Floor^($total / 2.0^) >> !chsortboxpath!
echo     } >> !chsortboxpath!
echo }^) >> !chsortboxpath!
echo $form.Controls.Add^($btnAuto^) >> !chsortboxpath!



echo $buttonClicked = $false >> !chsortboxpath!
echo $form.Add_Shown^({ $form.Activate^(^) }^) >> !chsortboxpath!
echo [void]$form.ShowDialog^(^) >> !chsortboxpath!

echo $form.Add_FormClosing^({ >> !chsortboxpath!
echo     if ^(-not $buttonClicked^) { >> !chsortboxpath!
echo         Write-Host "None" >> !chsortboxpath!
echo     } >> !chsortboxpath!
echo }^) >> !chsortboxpath!

echo /9j/4AAQSkZJRgABAQEAeAB4AAD/4QA6RXhpZgAATU0AKgAAAAgAA1EQAAEAAAABAQAAAFERAAQAAAABAAAAAFESAAQAAAABAAAAAAAAAAD/2wBDAAIBAQIBAQICAgICAgICAwUDAwMDAwYEBAMFBwYHBwcGBwcICQsJCAgKCAcHCg0KCgsMDAwMBwkODw0MDgsMDAz/2wBDAQICAgMDAwYDAwYMCAcIDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAz/wAARCAAYABgDASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD9cv2ov2grH9mn4X3firy/MW3AWRW6NmvlP4S/tjeOPhD8T/8Ait8MrD866z/gp9pniTTrD/ioI7dfh2x+do/vE/7XevhOb/gpD4Gh6t8Rj9PAAP8AWv524+ozqcbxnRi3GKjd7pX/AM7H57VqcbOp7nw+f4n76RNvjVvUA0V8BfsDftWx/Df4TQ+OPHTvG3xHmWeNl7MM4/maK/oeOyP0GN7an0X+1b8Hf+FwfDB4d25l+YZPY186/D//AIJB+B/ibYNN4yt5Lps4CIcE0UV+JRyXCyqqTWpvvI9F+En/AATrt/gtbrJcOvjwHtOwQ/qaKKK/bY/CjE//2Q== > "!tempfileprefix!fjpegify.b64"
certutil -decode "!tempfileprefix!fjpegify.b64" "!tempfileprefix!fjpegify.jpeg" >nul
del /q "!tempfileprefix!fjpegify.b64"
del /q "!loadingshowname!.b64"

:drawlogo
REM echo !gpu!
call :reallogo


:menu
echo 	[100m[97m[7m[O][27m - Open config file[0m		[100m[97m[7m[S][27m - Save config file[0m
rem echo.
echo 	[43m[97m[7m[M][27m - Choose the master audio[0m	[44m[97m[7m[C][27m - Choose the audio channels[0m
rem echo.
echo 	[44m[97m[7m[D][27m - Change display mode[0m	[104m[97m[7m[F][27m - Configure the audio channels[0m
rem echo.
echo 	[44m[97m[7m[G][27m - Global configuration[0m	[41m[34m[7m[L][27m - Clear the channels[0m
echo 	[45m[97m[7m[T][27m - Font configuration[0m	[45m[97m[7m[V][27m - Other video settings[0m
echo 	[44m[97m[7m[X][27m - Set output resolution, FPS[0m[101m[93m[7m[R][27m - Render^^![0m
rem echo !gpu!
echo.
rem for /l %%i in (1,1,100) do (

REM YEAS Fset i=1
CALL :channelbrr
REM :channelbrr
REM 	if not "!channel%i%!"=="" (
REM 		call :channelshow
REM 		goto channelbrr
REM 	)
	rem set i=1
	REM KIMINONAMAEWA set i=1
rem :forout

rem echo 	[33mChosen master audio: [93m!masteraudio![0m
CHOICE /C OSMCDFXRGLTV /N
if /i "!ERRORLEVEL!"=="5" (
		if "!linemode!"=="point" (
		set "linemode=p2p"
	) else if "!linemode!"=="p2p" (
		set "linemode=line"
	) else if "!linemode!"=="line" (
		set "linemode=cline"
	) else if "!linemode!"=="cline" (
		set "linemode=point
	) else (
		set "lmwv1=undefined"
	)
	goto drawlogo
)
if /i "!ERRORLEVEL!"=="7" (
	call :inputbox "Input Grammer: XRESxYRESxFPS (Example: 1280x720x60)" "NSOVVG"
	if not "!input!"=="" (
		for /f "tokens=1,2,3 delims=x" %%a in ("!input!") do (
			if not "%%a"=="" (
				set /a XX=%%a-1
				if {!XX!} == {-1} ( call :errmsg "Invalid number in XRES" ) ELSE ( set "x_res=%%a" )
			)
			if not "%%b"=="" (
				set /a XX=%%b-1
				if {!XX!} == {-1} ( call :errmsg "Invalid number in YRES" ) ELSE ( set "y_res=%%b" )
			)
			if not "%%c"=="" (
				set /a XX=%%c-1 
				if {!XX!} == {-1} ( call :errmsg "Invalid number in FPS" ) ELSE ( set "fps=%%c" )
			)
		)
	)
	goto drawlogo
)
if /i "!ERRORLEVEL!"=="3" (
	for /f "delims=" %%a in ('powershell -command "[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms') | Out-Null; $f = New-Object System.Windows.Forms.OpenFileDialog; $f.Filter = 'Audio Files|*.wav;*.mp3'; $f.Multiselect = $false; if ($f.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) { Write-Host $f.FileName } else { Write-Host 'None' }"') do set "selectedFile=%%a"
	IF NOT "!selectedFile!"=="None" set "masteraudio=!selectedFile!"
	goto drawlogo
)
if /i "!ERRORLEVEL!"=="4" (
	set pwshcmd=powershell -NoP -C "[System.Reflection.Assembly]::LoadWithPartialName('System.windows.forms')|Out-Null;$OFD = New-Object System.Windows.Forms.OpenFileDialog;$OFD.Multiselect = $True;$OFD.Filter = 'Audio Files|*.mp3;*.wav';$OFD.InitialDirectory = [Environment]::GetFolderPath('Desktop');$OFD.ShowDialog()|out-null;$OFD.FileNames"

	Set i=0
	for /f "delims=" %%I in ('!pwshcmd!') do (
		Set /A i+=1
		set "channel!i!=%%I"
		set "label!i!=Channel !i!"
		set "amp!i!=2"
		set "color!i!=#FFFFFF"
	)

	if !i! NEQ 0 (
		CALL :clearch
		set /a i-=1
		echo !i!
		set /a h1number=!i! / 2
		set /a hremainder=!i! %% 2

		if !hremainder! equ 0 (
			set /a h1number=!i! / 2
			set /a h2number=!i! / 2
		) else (
			set /a h1number=!i! / 2
			set /a h2number=!hremainder! + !h1number!
		)
		echo !h2number! !h1number!
		rem pause
		
	)
	
	goto drawlogo
)

if /i "!ERRORLEVEL!"=="6" (
	if not defined channel1 ( call :errmsg "You need to add the audio channels first" && goto drawlogo )
	call :reallogo
	set i=1
	set "choisenumbers="
	rem pause
	REM :channelconfig
	rem echo !i!
	rem echo !channel%i%!	xcopychannel%i%
	REM if not "!channel%i%!"=="" (
		rem set "choisenumbers=!choisenumbers!!i!"
	REM	set "choisenumbers=!i!"
	REM	call :channelshow
		rem echo !i!
		rem set "choisenumbers=!choisenumbers!!i!"
		rem set "choisenumbers=!choisenumbers!!chcount!"
	REM	goto channelconfig
	REM )
	REM FAset i=1
	CALL :channelbrr
	REM SORRYset i=1
	
	echo [0m
	rem echo !choisenumbers!
	
	REM CHOICE /C !choisenumbers! /N /M "[0mWhich channel would you like to configure?"
	:reask
	if defined channel2 (
		SET /P configch=Which channel would you like to configure? 
	) else (
		set configch=1
	)
	echo.
	rem echo aw%configch%fuck
	if not defined channel!configch! call :errmsg "Invalid vaule. Cancelling" && goto drawlogo
	rem SET "configch=!ERRORLEVEL!"
	ECHO Which configuration would you like to configure?
	echo 	[44m[97m[L] - Label Text[0m		[44m[97m[A] - Amplification[0m		[44m[97m[C] - Wave Color[0m		[100m[97m[X] - Cancel[0m
	CHOICE /C LACX /N
	if "!ERRORLEVEL!"=="1" (
		call :inputbox "Please Type Label Text for Channel No. !configch!" "NSOVVG"
		if not "!input!"=="" (
			set "label!configch!=!input!"
		)
	)
	if "!ERRORLEVEL!"=="2" (
		REM call :inputbox "Please Set Amplification for Channel No. !configch!" "NSOVVG"
		call :createnumberbox 50 !amp%configch%! "Please Set Amplification for Channel No. !configch!" 1
		if not "!selectedNumber!"=="None" (
			set "amp!configch!=!selectedNumber!"
		)
	)
	if "!ERRORLEVEL!"=="3" (
		rem call :inputbox "Please Type Hex Color for Channel No. !configch! (Example: 1CFF73)" "NSOVVG"
		for /f "delims=" %%A in ('powershell -NoProfile -ExecutionPolicy Bypass -File "!colorpickerpath!" "!color%configch%!"') do set "color=%%A"

		if not "!color!"=="None" (
			set "color!configch!=!color!"
			rem set "amp!configch!=!input!"
		)
	)
	
	goto drawlogo
	
	rem :channelconfigout
	
)

IF /I "!ERRORLEVEL!"=="2" (
	for /f "delims=" %%a in ('powershell -command "[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms') | Out-Null; $f = New-Object System.Windows.Forms.SaveFileDialog; $f.Filter = 'Config File|*.ini'; $f.Multiselect = $false; if ($f.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) { Write-Host $f.FileName } else { Write-Host 'None' }"') do set "saveFile=%%a"
	IF NOT "!saveFile!"=="None" (
		set i=1
		(echo x_res=!x_res!)> "!saveFile!"
		(echo y_res=!y_res!)>> "!saveFile!"
		(echo fps=!fps!)>> "!saveFile!"
		(echo masteraudio=!masteraudio!)>> "!saveFile!"
		(echo linemode=!linemode!)>> "!saveFile!"
		(echo dffont=!dffont!)>> "!saveFile!"
		(echo sizefont=!sizefont!)>> "!saveFile!"
		(echo colorfont=!colorfont!)>> "!saveFile!"
		(echo bgimage=!bgimage!)>> "!saveFile!"
		rem (echo bitrate=!bitrate!)>> "!saveFile!"
		(echo darkerbg=!darkerbg!)>> "!saveFile!"
		(echo chsort=!chsort!)>> "!saveFile!"
		
		:CHLOOP_SAVE
		if not "!channel%i%!"=="" (
			(echo channel!i!=!channel%i%!)>> "!saveFile!"
			(echo label!i!=!label%i%!)>> "!saveFile!"
			(echo amp!i!=!amp%i%!)>> "!saveFile!"
			(echo color!i!=!color%i%!)>> "!saveFile!"
			Set /A i+=1
			goto CHLOOP_SAVE
		)
	)
	goto drawlogo
)
IF /I "!ERRORLEVEL!"=="1" (
	for /f "delims=" %%a in ('powershell -command "[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms') | Out-Null; $f = New-Object System.Windows.Forms.OpenFileDialog; $f.Filter = 'Config File|*.ini'; $f.Multiselect = $false; if ($f.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) { Write-Host $f.FileName } else { Write-Host 'None' }"') do set "selectedFile=%%a"
	IF NOT "!selectedFile!"=="None" (
		SET i=0
		CALL :clearch
		for /f "tokens=1,* delims==" %%a in ('type "!selectedFile!"') do (
		set "%%a=%%b"
		)
	)
	goto drawlogo

)

if /i "!ERRORLEVEL!"=="8" (
	if not defined channel1 ( call :errmsg "You need to add the audio channels first" && goto drawlogo )
	if "!masteraudio!"=="None" ( call :errmsg "You need to choose the master audio" && goto drawlogo )
	echo 	[101m[93m[R] - Render^^![0m		[46m[97m[P] - Preview[0m		[100m[97m[X] - Cancel[0m
	CHOICE /C RPX /N
	if /i "!ERRORLEVEL!"=="1" (
		for /f "delims=" %%a in ('powershell -command "[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms') | Out-Null; $f = New-Object System.Windows.Forms.SaveFileDialog; $f.Filter = 'Video File|*.mp4'; $f.Multiselect = $false; if ($f.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) { Write-Host $f.FileName } else { Write-Host 'None' }"') do set "saveFile=%%a"
		IF NOT "!saveFile!"=="None" (
			set "ffmpegoutput=!saveFile!"
			set "renderorpreview=2"
			goto render
		)
	)
	if /i "!ERRORLEVEL!"=="2" (
			set "renderorpreview=1"
			goto render
	)
	goto drawlogo
)
if /i "!ERRORLEVEL!"=="9" (
	if not defined channel1 ( call :errmsg "You have no channels to configure" && goto drawlogo )
	set i=0
	echo.
	ECHO [0mWhich configuration would you like to configure globally?
	echo 	[44m[97m[L] - Label Text[0m		[44m[97m[A] - Amplification[0m		[44m[97m[C] - Wave Color[0m
	echo 	[44m[97m[R] - Reorder the channels[0m					[100m[97m[X] - Cancel[0m
	CHOICE /C LACXR /N
	echo.
	if /i "!ERRORLEVEL!"=="1" (
		rem set i=0
		echo Which channel name template do you want?
		echo 	[44m[97m[1] - "Channel No. $"[0m		[44m[97m[2] - "Channel #$"[0m		[44m[97m[3] - Use the name of the file[0m
		echo		[44m[97m[4] - Custom[0m			[44m[97m[5] - Clear[0m			[100m[97m[X] - Cancel[0m
		rem CHOICE /C 12345X /N
		for /f %%A in ('powershell -command "$key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').Character; Write-Host $key"') do set "userInput=%%A"
		if /i "!userInput!"=="5" (
			:labelset1
			Set /A i+=1
			if not "!channel%i%!"=="" (
				set "label!i!="
				goto labelset1
			)
		)
		IF /I "!userInput!"=="1" (
			:labelset2
			Set /A i+=1
			if not "!channel%i%!"=="" (
				set "label!i!=Channel No. !i!"
				goto labelset2
			)
		)
		IF /I "!userInput!"=="2" (
			:labelset3
			Set /A i+=1
			if not "!channel%i%!"=="" (
				set "label!i!=Channel #!i!"
				goto labelset3
			)
		)
		IF /I "!userInput!"=="3" (
			:labelset4
			Set /A i+=1
			if not "!channel%i%!"=="" (
				rem set "label!i!=Channel No. !i!"
				for %%F in ("!channel%i%!") do set "label!i!=%%~nF"
				goto labelset4
			)
		)
		IF /I "!userInput!"=="4" (
			call :inputbox "The following text applies to all channels, the letter $ is assigned to the channel number (Example: CH$ = CH1, CH2, CH3...)" "NSOVVG"
			if not "!input!"=="" (
				rem set labelstr=!input:$=%i%!
				:labelset5
				Set /A i+=1
				set labelstr=!input:$=%i%!
				if not "!channel%i%!"=="" (
					set "label!i!=!labelstr!"
					goto labelset5
				)
			)
		)
	)
	if "!ERRORLEVEL!"=="2" (
		rem call :inputbox "Please Set Amplification for All of Channels" "NSOVVG"
		call :createnumberbox 50 !amp1! "Please Set Amplification" 1

		rem if not "!input!"=="" (
		if not "!selectedNumber!"=="None" (

		:labelset6
			Set /A i+=1
			if not "!channel%i%!"=="" (
				set "amp!i!=!selectedNumber!"
				goto labelset6
			)
		)
	)
	if "!ERRORLEVEL!"=="3" (

		for /f "delims=" %%A in ('powershell -NoProfile -ExecutionPolicy Bypass -File "!colorpickerpath!" "!color1!"') do set "color=%%A"

		if not "!color!"=="None" (

			:labelset7
				Set /A i+=1

				if not "!channel%i%!"=="" (
					rem set "amp!i!=!input!"
					set "color!i!=!color!"
					goto labelset7
				)
		)
	)
	IF "!ERRORLEVEL!"=="5" (
	set i=1
	for /f "tokens=*" %%A in ('powershell -ExecutionPolicy Bypass -File "!reorderboxpath!"') do (
		set "output=%%A"
		if "!output!" neq "None" (
			REM set "channel!i!=!output!"
			set "buffer_channel!i!=!channel%%A!"
			set "buffer_label!i!=!label%%A!"
			set "buffer_amp!i!=!amp%%A!"
			set "buffer_color!i!=!color%%A!"
			rem ECHO "buffer_color!i! !channel%%a!"
			set /a i+=1
			rem echo Reordered channel: !output!
			
		)
		
	) 
	rem PAUSE
	REM set i=0
	if "!output!" neq "None" (
		 for /L %%i in (1,1,!i!) do (
		rem echo %%i
		rem set /a sum+=%%i
			set "channel%%i=!buffer_channel%%i!"
			set "label%%i=!buffer_label%%i!"
			set "amp%%i=!buffer_amp%%i!"
			set "color%%i=!buffer_color%%i!"
		)
		rem echo !buffer_channel3!
		rem pause
	)
	rem pause
rem pause
)
		goto drawlogo
)
if /i "!ERRORLEVEL!"=="10" (
	if not defined channel1 ( call :errmsg "You have no channels to clear" && goto drawlogo )
	SET i=0
	call :MsgBox "You imported a lot of channels, are you sure to clear everything?"  "VBYesNo+VBQuestion" "NSOVVG"
	REM echo !errorlevel!
	REM pause
	if "!errorlevel!"=="6" CALL :clearch

	goto drawlogo
	
)

if /i "!ERRORLEVEL!"=="11" (
ECHO [101m[97m[1m[WARNING] Nothing is supported other than "Font selection", "Font color", and "Font size".[0m

	call :createfontpicker
	for /f "tokens=1,2 delims==" %%a in ('powershell -ExecutionPolicy Bypass -File "!fontpickerpath!"') do (
		if "%%a"=="Canceled" goto drawlogo
		if "%%a"=="FontName" set "dffont=%%b"
		if "%%a"=="FontSize" set "sizefont=%%b"
		if "%%a"=="FontColor" set "colorfont=%%b"
	)

	GOTO drawlogo
)

if /i "!ERRORLEVEL!"=="12" (
	echo.
	ECHO [0mWhich configuration would you like to configure?
	echo 	[44m[97m[I] - Background Image / Video[0m						[44m[97m[C] - Background Color[0m
	if "!gpu!"=="libx264" (
		echo 	[46m[97m[S] - Use Hardware Rendering For This Time[0m				[44m[97m[W] - Channel Sorting[0m
	) else (
		echo 	[41m[97m[S] - Use Software Rendering For This Time ^(libx264^)[0m			[44m[97m[W] - Channel Sorting[0m
	)
	echo 	[100m[97m[X] - Cancel[0m
	CHOICE /C BIXCSW /N
	echo.
	if /i "!ERRORLEVEL!"=="2" (
		for /f "delims=" %%a in ('powershell -command "[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms') | Out-Null; $f = New-Object System.Windows.Forms.OpenFileDialog; $f.Filter = 'Picture Files|*.png;*.jpg;*.mp4;*.jpeg;*.avi'; $f.Multiselect = $false; if ($f.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) { Write-Host $f.FileName } else { Write-Host 'None' }"') do set "selectedFile=%%a"
		IF NOT "!selectedFile!"=="None" (
			rem set "bgimage=!selectedFile!"
			ECHO [0mWould you like to get darker background?
			echo 	[102m[97m[Y] - Yes![0m				[41m[97m[N] - No[0m			[100m[97m[X] - Cancel[0m
			for /f %%A in ('powershell -command "$key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').Character; Write-Host $key"') do set "userInput=%%A"
			if /i "!userInput!"=="y" set "darkerbg=on"
			if /i "!userInput!"=="n" set "darkerbg=off"
			if /i not "!userInput!"=="x" set "bgimage=!selectedFile!"
		)
		rem goto drawlogo
	)
	IF /I "!ERRORLEVEL!"=="4" (
		for /f "delims=" %%A in ('powershell -NoProfile -ExecutionPolicy Bypass -File "!colorpickerpath!" "!color%configch%!"') do set "color=%%A"

		if not "!color!"=="None" (
			set "bgimage=!color!"
			rem if not "!color!"=="None" set "bgimage=#!color:~2!"
			rem set "amp!configch!=!input!"
		)
		REM if not "!color!"=="None" set "bgimage=#!color:~2!"
	)
	IF /I "!ERRORLEVEL!"=="1" (
		call :createnumberbox 100000 !bitrate:~0,-1! "Please set the bitrate of the video. (kbps)" 100
		rem for /f "usebackq delims=" %%i in (`powershell -NoProfile -ExecutionPolicy Bypass -File "!numberboxpath!"`) do (
		rem 	set selectedNumber=%%i
		rem )
		if not "!selectedNumber!"=="None" set "bitrate=!selectedNumber!k"
	)
	rem 
	IF /I "!ERRORLEVEL!"=="5" (
		if NOT "!gpu!"=="libx264" (
			set "gpu=libx264"
		) else (
			call :gpudetect
			if "!ERRORLEVEL!"=="2" ( call :errmsg "It appears that your computer does not support hardware rendering. Use software rendering instead" )
		)
	)
	
	if /i "!ERRORLEVEL!" EQU "6" (
		if not defined channel1 ( call :errmsg "You need to add the audio channels first" && goto drawlogo )
		set /a SORT2_h1number=!chcount_fortitle! / 2
		set /a SORT2_hremainder=!chcount_fortitle! %% 2	
		if !SORT2_hremainder! equ 0 (
			set /a SORT2_h2number=!chcount_fortitle! / 2
		) else (
			set /a SORT2_h2number=!SORT2_hremainder! + !SORT2_h1number!
		)
		
		if "!chsort!"=="AUTO" (
			set "SORT_h1number=!SORT2_h1number!"
			set "SORT_h2number=!SORT2_h2number!"
			
		) else (
			for /f "tokens=1,2 delims==" %%a in ("!chsort!") do (
				set "SORT_h1number=%%a"
				set "SORT_h2number=%%b"
			)
		)
			
		for /f "tokens=1,2 delims==" %%a in ('powershell -Command "& {!chsortboxpath! !SORT_h2number! !SORT_h1number!}"') do (
			if "%%a" NEQ "None" (
				if "!SORT2_h2number!"=="%%a" ( set "chsort=AUTO" ) ELSE ( set "chsort=%%a=%%b" )
				REM if "!SORT2_h2number!"=="%%a" if "!SORT2_h1number!"=="%%b" ( set "chsort=AUTO" ) ELSE ( set "chsort=%%a=%%b" )
			)
			ECHO %%a%%b
			echo !SORT2_h2number!x!SORT2_h1number!
			pause
		)
		rem echo !SORT_h1number! !SORT_h2number!
		rem pause
		set "SORT_h1number="
		set "SORT_h2number="
		set "SORT_hremainder="
		set "SORT2_h1number="
		set "SORT2_h2number="
		set "SORT2_hremainder="
	)
	goto drawlogo
)
rem pause 
echo [91mIf you are seeing this message, there is a major bug in this script. Go ahead and tell the developers about this! This stupid script doesn't generate any debug logs, but you don't lose anything \_(¾²)_/[0m
PAUSE
exit
REM Input routine for batch using VBScript to provide input box
REM Stephen Knight, October 2009, http://www.dragon-it.co.uk/

:InputBox
set input=
set heading=%~2
set message=%~1
echo wscript.echo inputbox(WScript.Arguments(0),WScript.Arguments(1)) >"!tempfileprefix!input.vbs"
for /f "tokens=* delims=" %%a in ('cscript //nologo "!tempfileprefix!input.vbs" "!message!" "!heading!"') do set input=%%a
goto :EOF

:errmsg
echo msgbox "%~1^!",vbOKOnly+vbCritical,"NSOVVG" > "!tempfileprefix!error.vbs"
cscript //nologo "!tempfileprefix!error.vbs"
DEL /Q "!tempfileprefix!error.vbs"
goto :EOF

:MsgBox prompt type title
 rem setlocal enableextensions
 set "tempFile=!tempfileprefix!%~nx0.%random%%random%%random%vbs.tmp"
 >"!tempFile!" echo(WScript.Quit msgBox("%~1",%~2,"%~3") & cscript //nologo //e:vbscript "!tempFile!"
 set "exitCode=!errorlevel!" & del "!tempFile!" >nul 2>nul

 exit /b !exitCode!
 
:reallogo
cls
SET i=0
if "!linemode!"=="point" (
	set "lmwv1=.¡¤'¡¤.¡¤'¡¤.¡¤'¡¤.¡¤"
) else if "!linemode!"=="p2p" (
	set "lmwv1=  /\/\/\/\/\/\/\"
) else if "!linemode!"=="line" (
	set "lmwv1= ¡ã¡ã¡ã¡ã¡ã¡ã¡ã¡ã¡ã¡ã¡ã¡ã¡ã¡ã"
) else if "!linemode!"=="cline" (
	set "lmwv1=¡ß¡ß¡ß¡ß¡ß¡ß¡ß¡ß¡ß¡ß¡ß¡ß¡ß¡ß"
) else (
	set "lmwv1=undefined"
)
if "!masteraudio!"=="None" (
	set "mastername=[91mNone"
) else (
	for %%F in ("!masteraudio!") do set "mastername=[93m"%%~nxF""
)

if "!bgimage!"=="None" (
	set "imagename=[32mBackground Image:	[93m[91mNone[97m"
) else if "!bgimage:~0,1!"=="#" (
	set "hexColor=!bgimage:~1!"
	set /a r=0x!hexColor:~0,2!
	set /a g=0x!hexColor:~2,2!
	set /a b=0x!hexColor:~4,2!

	set "displaybgimage=[38;2;!r!;!g!;!b!m!bgimage!"

	set "imagename=[32mBackground Color:	[93m!displaybgimage![97m"
) else (
	for %%F in ("!bgimage!") do set "imagename=[32mBackground Image:	[93m"%%~nxF"[97m"
)
	set strLen=0
	for /l %%a in (0,1,64) do if not "!dffont:~%%a,1!" == "" set /a strLen+=1
	if !strLen! geq 23 (
		set "displayfont=!dffont!"
	) else (
		set /a remainLen=23-!strLen!
		set "fillString="
		for /l %%i in (1,1,!remainLen!) do set "fillString=!fillString! "
		set "displayfont=!dffont!!fillString!"
	)
	set "hexColor=!colorfont:~1!"
set /a r=0x!hexColor:~0,2!
set /a g=0x!hexColor:~2,2!
set /a b=0x!hexColor:~4,2!
rem echo !r!!g!!b!!hexColor!
set "displaycolorfont=[38;2;!r!;!g!;!b!m!colorfont!"
:CHLOOP_FORTITLE
	Set /A i+=1
	if defined channel1 ( if not "!channel%i%!"=="" set "chcount_fortitle=!i!" && goto CHLOOP_FORTITLE ) else ( set "chcount_fortitle=0" )
	rem ECHO !chcount_fortitle!
rem if defined channel1 echo !chcount!
if "!chsort!"=="AUTO" (
	set "displaychannelsorting=	[91mAuto"
) else (
	for /f "tokens=1,2 delims==" %%a in ("!chsort!") do (
		set /a CCresult=%%a + %%b
		IF "!CCresult!" NEQ "!chcount_fortitle!" ( set "chsort=AUTO" && set "displaychannelsorting=	[91mAuto" ) ELSE ( set "displaychannelsorting=	[93mLeft=%%a, Right=%%b" )
	)
	
)
rem if not defined h1count set "h1count=0"
rem if not defined h2count set "h2count=0"
rem if "!h1count!"=="0" (
rem 	if "!h2count!"=="0" (
rem 		set "displaychannelsorting=	[Auto"
rem 	) else (
rem 		set "displaychannelsorting=Left=!h2count!, Right=!h1count!"
rem 	)
rem ) else ( 
rem 	set "displaychannelsorting=Left=!h2count!, Right=!h1count!"
rem )

echo [90mNSOVVG Version v!NSOVVGVERSION![0m
echo    [1m[97m         ,--.              ,----..                                     	¦®¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬[Current Settings]¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¯
echo           ,--.'^| .--.--.     /   /   \                         ,----..    	¦­  [32mChosen Master Audio: !mastername![97m		¦­
echo       ,--,:  : ^|/  /    '.  /   .     :       ,---.      ,---./   /   \   	¦­  [32mVideo Resolution:	[93m!x_res! x !y_res![97m		¦­
echo    ,`--.'`^|  ' ^|  :  /`. / .   /   ;.  \     /__./^|     /__./^|   :     :  	¦­  [32mFPS:			[93m!fps!FPS[97m				¦­
echo    ^|   :  :  ^| ;  ^|  ^|--` .   ;   /  ` ;,---.;  ; ^|,---.;  ; .   ^|  ;. /  	¦­  !imagename!		¦­
echo    :   ^|   \ ^| ^|  :  ;_   ;   ^|  ; \ ; /___/ \  ^| /___/ \  ^| .   ; /--`   	¦­  [32mDisplay Mode: [93m!linemode! !lmwv1![97m	¦­
echo    ^|   : '  '; ^|\  \    `.^|   :  ^| ; ^| \   ;  \ ' \   ;  \ ' ;   ^| ;  __  	¦­  [32mChosen Font:	[93m!displayfont![97m¦­
echo    '   ' ;.    ; `----.   .   ^|  ' ' ' :\   \  \: ^|\   \  \: ^|   : ^|.' .' 	¦­  [32mFont Size:	[93m!sizefont![97m											¦­
echo    ^|   ^| ^| \   ^| __ \  \  '   ;  \; /  ^| ;   \  ' . ;   \  ' .   ^| '_.' : 	¦­  [32mFont Color:	!displaycolorfont![97m												¦­
echo    '   : ^|  ; .'/  /`--'  /\   \  ',  /   \   \   '  \   \   '   ; : \  ^| 	¦­  [32mChannel Sorting:[97m !displaychannelsorting![97m												¦­
echo    ^|   ^| '`--' '--'.     /  ;   :    /     \   `  ;   \   `  '   ^| '/  .' 	¦­												¦­
echo    '   : ^|       `--'---'    \   \ .'       :   \ ^|    :   \ ^|   :    /   	¦­												¦­
echo    ;   ^|.'                    `---`          '---"      '---" \   \ .'    	¦±¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦¬¦°
echo    '---'                                                       `---`      [0m
echo.             Not Serious Oscilloscope View Video Generator
echo.

goto :EOF

:channelshow
if !i! equ 1 echo	[100m[97mChannels[0m
if "!label%i%!"=="" ( set "temp_displayedlabel=[91mNone" ) else ( set "temp_displayedlabel="!label%i%!"" )
set strLen=0
for /l %%a in (0,1,64) do if not "!temp_displayedlabel:~%%a,1!" == "" set /a strLen+=1
	if !strLen! geq 23 (
		set "displayedlabel=!temp_displayedlabel!"
	) else (
		set /a remainLen=23-!strLen!
		set "fillString="
		for /l %%i in (1,1,!remainLen!) do set "fillString=!fillString! "
		set "displayedlabel=!temp_displayedlabel!!fillString!"
	)
rem if not exist "!channel%i%!" ( call :errmsg "Couldn't find " && goto drawlogo )
for %%F in ("!channel%i%!") do set "displaych=%%~nxF"
rem if not exist "!channel%i%!" ( call :errmsg "Couldn't find the file !displaych!" && goto drawlogo )
rem @echo on
set "hexColor=!color%i%:~1!"
set /a r=0x!hexColor:~0,2!
set /a g=0x!hexColor:~2,2!
set /a b=0x!hexColor:~4,2!
rem echo !r!!g!!b!!hexColor!
set "displaycolor=[38;2;!r!;!g!;!b!m!color%i%!"
echo 	[96m[7mChannel No. !i![27m [93m[7m"!displaych!"[27m && echo [36m	 ¦¦¦¡¦¡¦¡ [96mLabel Text: [93m!displayedlabel![100m[97m^|^|[0m	[96mAmplification: [93m!amp%i%!	[100m[97m^|^|[0m	[96mWave Color: !displaycolor![0m
set chcount=!i!
rem echo !chcount!
Set /A i+=1

goto :EOF

		:clearch
		Set /A i+=1
		if not "!channel%i%!"=="" (
			set "channel!i!="
			goto clearch
		)
		goto :EOF
		
:createfontpicker
echo Add-Type -AssemblyName System.Windows.Forms > !fontpickerpath!
echo $fontDialog = New-Object System.Windows.Forms.FontDialog >> !fontpickerpath!

echo $fontDialog.ShowColor = $true >> !fontpickerpath!

echo $defaultFont = New-Object System.Drawing.Font("!dffont!", !sizefont!, [System.Drawing.FontStyle]::Regular) >> !fontpickerpath!
echo $fontDialog.Font = $defaultFont >> !fontpickerpath!

echo $defaultColor = [System.Drawing.ColorTranslator]::FromHtml^("!colorfont!"^) >> !fontpickerpath!
echo $fontDialog.Color = $defaultColor >> !fontpickerpath!
rem THANK YOU STACKOVERFLOW NERDS

echo if ($fontDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK^) { >> !fontpickerpath!
echo Write-Host "FontName=$($fontDialog.Font.Name)" >> !fontpickerpath!
echo Write-Host "FontSize=$([int]$fontDialog.Font.Size)" >> !fontpickerpath!
rem echo Write-Host "FontColor=$($fontDialog.Color)" >> !fontpickerpath!
echo $red = $fontDialog.Color.R >> !fontpickerpath!
echo $green = $fontDialog.Color.G >> !fontpickerpath!
echo $blue = $fontDialog.Color.B >> !fontpickerpath!
echo $hexshit = "#{0:X2}{1:X2}{2:X2}" -f $red, $green, $blue >> !fontpickerpath!
echo Write-Host "FontColor=$hexshit" >> !fontpickerpath!
echo } else { Write-Host "Canceled" } >> !fontpickerpath!

goto :EOF

:createnumberbox
rem set "numberboxpath=asd.ps1"
echo Add-Type -AssemblyName System.Windows.Forms> !numberboxpath!
echo Add-Type -AssemblyName System.Drawing>> !numberboxpath!
echo. >> !numberboxpath!

echo $form ^= New-Object System.Windows.Forms.Form>> !numberboxpath!
echo $form.Text ^= 'NSOVVG'>> !numberboxpath!
echo $form.Size ^= New-Object System.Drawing.Size^(250, 150^)>> !numberboxpath!
echo $form.StartPosition ^= 'CenterScreen'>> !numberboxpath!
echo. >> !numberboxpath!

echo $label ^= New-Object System.Windows.Forms.Label>> !numberboxpath!
echo $label.Text ^= "%~3">> !numberboxpath!
echo $label.AutoSize ^= $true>> !numberboxpath!
echo $label.Location ^= New-Object System.Drawing.Point(0, 10)>> !numberboxpath!
echo $form.Controls.Add($label)>> !numberboxpath!

echo $numericUpDown ^= New-Object System.Windows.Forms.NumericUpDown>> !numberboxpath!
echo $numericUpDown.Location ^= New-Object System.Drawing.Point^(50, 30^)>> !numberboxpath!
echo $numericUpDown.Width ^= 100 >> !numberboxpath!
echo $numericUpDown.Minimum ^= 0 >> !numberboxpath!
echo $numericUpDown.Maximum ^= %~1 >> !numberboxpath!
echo $numericUpDown.DecimalPlaces ^= 0 >> !numberboxpath!
echo $numericUpDown.Value ^= %~2 >> !numberboxpath!
ECHO $numericUpDown.Increment = %~4 >> !numberboxpath!
echo $form.Controls.Add^($numericUpDown^)>> !numberboxpath!
echo. >> !numberboxpath!

echo $okButton ^= New-Object System.Windows.Forms.Button>> !numberboxpath!
echo $okButton.Text ^= 'OK'>> !numberboxpath!
echo $okButton.Location ^= New-Object System.Drawing.Point^(30, 70^)>> !numberboxpath!
echo $okButton.Add_Click^({>> !numberboxpath!
echo     $form.Tag ^= $numericUpDown.Value>> !numberboxpath!
echo     $form.Close^(^)>> !numberboxpath!
echo }^)>> !numberboxpath!
echo $form.Controls.Add^($okButton^)>> !numberboxpath!
echo. >> !numberboxpath!

echo $cancelButton ^= New-Object System.Windows.Forms.Button>> !numberboxpath!
echo $cancelButton.Text ^= 'Cancel'>> !numberboxpath!
echo $cancelButton.Location ^= New-Object System.Drawing.Point^(120, 70^)>> !numberboxpath!
echo $cancelButton.Add_Click^({>> !numberboxpath!
echo     $form.Tag ^= 'None'>> !numberboxpath!
echo     $form.Close^(^)>> !numberboxpath!
echo }^)>> !numberboxpath!
echo $form.Controls.Add^($cancelButton^)>> !numberboxpath!
echo. >> !numberboxpath!

echo $form.Add_FormClosing^({>> !numberboxpath!
echo     if ^($form.Tag -eq $null^) {>> !numberboxpath!
echo         $form.Tag ^= 'None'>> !numberboxpath!
echo     }>> !numberboxpath!
echo }^)>> !numberboxpath!
echo. >> !numberboxpath!

echo $form.ShowDialog^(^) ^| Out-Null>> !numberboxpath!
echo. >> !numberboxpath!

echo Write-Host $form.Tag>> !numberboxpath!
echo. >> !numberboxpath!
echo. >> !numberboxpath!
for /f "usebackq delims=" %%i in (`powershell -NoProfile -ExecutionPolicy Bypass -File "!numberboxpath!"`) do (
			set selectedNumber=%%i
)
del /q !numberboxpath!
goto :eof

:gpudetect
for /f "tokens=2 delims==" %%G in ('wmic path win32_videocontroller get name /value') do set "gpu_name=%%G"

echo !gpu_name! | find /i "NVIDIA" >nul
if %errorlevel%==0 (
    set "gpu=h264_nvenc"
    rem goto bfdrawlogo
)

echo !gpu_name! | find /i "Intel" >nul
if %errorlevel%==0 (
    set "gpu=h264_qsv"
    rem goto bfdrawlogo
)

echo !gpu_name! | find /i "AMD" >nul
if %errorlevel%==0 (
    set "gpu=h264_amf"
    rem goto bfdrawlogo
)

rem exit /b 2

rem exit /b 2
if not defined gpu ( set "gpu=libx264" && exit /b 2 ) else ( exit /b 1 )
rem goto :eof
:channelbrr
	SET i=1
	:CHLOOP
	if not "!channel%i%!"=="" (
		call :channelshow
		goto CHLOOP
	)
	set i=1
	goto :EOF
	
:render
:: ¸¶½ºÅÍ ¿Àµð¿À ÆÄÀÏ (%1)
rem set "masterAudio=%~1"
rem echo on

:: Ã¤³Î ¿Àµð¿À ÆÄÀÏµéÀ» Ã³¸® (%2ºÎÅÍ ³¡±îÁö)
set channelCount=0
set H1Count=0
set H2Count=0
set "channelInputs="
set "filterComplex="
set "layout="
IF "!chsort!"=="AUTO" ( set "autosortvaule=4" ) else ( set "autosortvaule=1" )
set "outer="
set "H1F="
set "H2F="
set "bgcf1="
set "bgcf2="
set "linemode2="
set "bitrate=5000k"
set "scalemode=lin"
set "linemode2=!linemode!:split_channels=0"
set stack_num=!chcount!
set /a stack_y_res=y_res / stack_num
set /a remainder=y_res %% stack_num
echo !stack_num!
set /a last_stack_y_res=stack_y_res + remainder
rem set "drawtext=drawtext=text='Channel 3':x=10:y=10:fontsize=24:fontcolor=white"
rem IF "!chsort!"=="AUTO" (
	if !chcount! GTR !autosortvaule! (
		if "!chsort!"=="AUTO" (
			echo AUTO CHANNEL SORTING

			set /a h1number=!chcount! / 2
			set /a hremainder=!chcount! %% 2

			if !hremainder! equ 0 (
				rem set /a h1number=!chcount! / 2
				set /a h2number=!chcount! / 2
			) else (
				rem set /a h1number=!chcount! / 2
				set /a h2number=!hremainder! + !h1number!
			)
		) else if "!chsort!"=="ALLVERTICAL" (
			echo A
		) else for /f "tokens=1,2 delims==" %%a in ("!chsort!") do (
			set "h2number=%%a"
			set "h1number=%%b"
		)
		echo !h2number! !h1number!
		set /a H1_y_res=y_res / h2number
		set /a H1remainder=y_res %% h2number
		set /a last_H1_y_res=H1_y_res + H1remainder

		set /a H2_y_res=y_res / h1number
		set /a H2remainder=y_res %% h1number
		set /a last_H2_y_res=H2_y_res + H2remainder

		set /a x_reshalf=x_res/2
		rem echo !x_res!
		ECHO H1 : !H1_y_res!, !last_H1_y_res!
		echo H2 : !H2_y_res!, !last_H2_y_res!

	)
rem )
:loop
rem shift
set /a channelCount+=1
set "beforeshowwaves=volume=!amp%channelCount%![g"
if !channelCount! gtr !chcount! goto endloop
rem set /a channelCount+=1
set "channelInputs=!channelInputs! -i "!channel%channelCount%!""

if defined label!channelCount! (
	set "drawtext=[wave%channelCount%]drawtext=text='!label%channelCount%!':font='!dffont!':x=10:y=10:fontsize=!sizefont!:fontcolor=!colorfont![wave%channelCount%];"
) else (
	set "drawtext="
)

if !chcount! GTR !autosortvaule! (

	if !channelCount! LEQ !h2number! (
		set /a H1Count+=1
		if "!H1Count!"=="!h2number!" (

				set "H1F=!H1F! [%channelCount%:a]!beforeshowwaves!%channelCount%];[g%channelCount%]showwaves=s=!x_reshalf!x!last_H1_y_res!:mode=!linemode2!:colors=!color%channelCount%!:rate=!fps!:scale=!scalemode![wave%channelCount%];!drawtext!"
				set "layout=!layout![wave%channelCount%]vstack=inputs=!H1Count![left];"
		) else (

				set "H1F=!H1F! [%channelCount%:a]!beforeshowwaves!%channelCount%];[g%channelCount%]showwaves=s=!x_reshalf!x!H1_y_res!:mode=!linemode2!:colors=!color%channelCount%!:rate=!fps!:scale=!scalemode![wave%channelCount%];!drawtext!"
				set "layout=!layout![wave%channelCount%]"
		)

			REM :: set "layout=!layout![wave%channelCount%]"

	) else (
		set /a H2Count+=1
		if "!H2Count!"=="!h1number!" (
				

				set "H2F=!H2F! [%channelCount%:a]!beforeshowwaves!%channelCount%];[g%channelCount%]showwaves=s=!x_reshalf!x!last_H2_y_res!:mode=!linemode2!:colors=!color%channelCount%!:rate=!fps!:scale=!scalemode![wave%channelCount%];!drawtext!"
				set "layout=!layout![wave%channelCount%]vstack=inputs=!H2Count![right];"
		) else (

				set "H2F=!H2F! [%channelCount%:a]!beforeshowwaves!%channelCount%];[g%channelCount%]showwaves=s=!x_reshalf!x!H2_y_res!:mode=!linemode2!:colors=!color%channelCount%!:rate=!fps!:scale=!scalemode![wave%channelCount%];!drawtext!"
				set "layout=!layout![wave%channelCount%]"
		)

			REM :: set "layout=!layout![wave%channelCount%]"

	)
	
) else (
	if "!channelCount!"=="!chcount!" (
		if !chcount!==1 (
			set "filterComplex=!filterComplex! [%channelCount%:a]!beforeshowwaves!%channelCount%];[g%channelCount%]showwaves=s=!x_res!x!last_stack_y_res!:mode=!linemode2!:colors=!color%channelCount%!:rate=!fps!:scale=!scalemode![wave%channelCount%];!drawtext!"
		) else (
			set "filterComplex=!filterComplex! [%channelCount%:a]!beforeshowwaves!%channelCount%];[g%channelCount%]showwaves=s=!x_res!x!last_stack_y_res!:mode=!linemode2!:colors=!color%channelCount%!:rate=!fps!:scale=!scalemode![wave%channelCount%];!drawtext!"
		)
	) else (
		if !chcount!==1 (
			set "filterComplex=!filterComplex! [%channelCount%:a]!beforeshowwaves!%channelCount%];[g%channelCount%]showwaves=s=!x_res!x!stack_y_res!:mode=!linemode2!:colors=!color%channelCount%!:rate=!fps!:scale=!scalemode![wave%channelCount%];!drawtext!"
		) else (
			set "filterComplex=!filterComplex! [%channelCount%:a]!beforeshowwaves!%channelCount%];[g%channelCount%]showwaves=s=!x_res!x!stack_y_res!:mode=!linemode2!:colors=!color%channelCount%!:rate=!fps!:scale=!scalemode![wave%channelCount%];!drawtext!"
		)
	)
	if !chcount!==1 (
		set "layout="
	) else (
		set "layout=!layout![wave%channelCount%]"
	)
)
rem shift
rem set /a i-=1
goto loop

:endloop
set channelCount+=1
rem echo %channelCount% %i%
:: ÃÖÁ¾ Ãâ·Â ·¹ÀÌ¾Æ¿ôÀ» Á¤ÀÇ
if "!bgimage!"=="None" (
	set "bgcf1="
	set "bgcf2="
) else if "!bgimage:~0,1!"=="#" (
	rem (This is only a temporary solution. We will optimize it further soon)
	if "!chcount!"=="1" (
		set "bgcf1=color=c=!bgimage!:size=!x_res!x!y_res!:d=1 [bgimg];[bgimg][wave1]overlay=x=0:y=0[wave1]"
	) else (
		set "bgcf1=color=c=!bgimage!:size=!x_res!x!y_res!:d=1 [bgimg];[bgimg][v2]overlay=x=0:y=0[v2]"
	)
) else (
	rem (This is only a temporary solution. We will optimize it further soon)
	if "!chcount!"=="1" (
			if /i "!darkerbg!"=="on" (
			set "bgcf1=[!channelCount!:v]scale='if(gt(iw/ih,!x_res!/!y_res!),!x_res!,-2)':'if(gt(iw/ih,!x_res!/!y_res!),-2,!y_res!)', pad=width=!x_res!:height=!y_res!:x=(ow-iw)/2:y=(oh-ih)/2[bgimg];[bgimg]eq=brightness=-0.5[bgimg];[bgimg][wave1]overlay=x=0:y=0[wave1];"
		) else (
			set "bgcf1=[!channelCount!:v]scale='if(gt(iw/ih,!x_res!/!y_res!),!x_res!,-2)':'if(gt(iw/ih,!x_res!/!y_res!),-2,!y_res!)', pad=width=!x_res!:height=!y_res!:x=(ow-iw)/2:y=(oh-ih)/2[bgimg];[bgimg][wave1]overlay=x=0:y=0[wave1];"
		)
		
	) else (
		if /i "!darkerbg!"=="on" (
			set "bgcf1=[!channelCount!:v]scale='if(gt(iw/ih,!x_res!/!y_res!),!x_res!,-2)':'if(gt(iw/ih,!x_res!/!y_res!),-2,!y_res!)', pad=width=!x_res!:height=!y_res!:x=(ow-iw)/2:y=(oh-ih)/2[bgimg];[bgimg]eq=brightness=-0.5[bgimg];[bgimg][v2]overlay=x=0:y=0[v2];"
		) else (
			set "bgcf1=[!channelCount!:v]scale='if(gt(iw/ih,!x_res!/!y_res!),!x_res!,-2)':'if(gt(iw/ih,!x_res!/!y_res!),-2,!y_res!)', pad=width=!x_res!:height=!y_res!:x=(ow-iw)/2:y=(oh-ih)/2[bgimg];[bgimg][v2]overlay=x=0:y=0[v2];"
		)
		rem set "bgcf1=[!channelCount!:v]scale^=!x_res!:!y_res!:force_original_aspect_ratio^=decrease,pad^=!x_res!:!y_res!:-1:-1:color^=black[v2]"
	)
	set "bgcf2=-i "!bgimage!" "
)
REM set "outer=-c:v !gpu! -format yuv420p -map [v2]"
if "!chcount!"=="1" (
	set "layout=!bgcf1!"
	 set "outer=-c:v !gpu! -format yuv420p -b:v !bitrate! -map [wave1]"
) else if !chcount! GTR !autosortvaule! (
	set "filterComplex=!H1F!!H2F!"
	set "layout=!layout![left][right]hstack=inputs=2[v2];!bgcf1!"
	 set "outer=-c:v !gpu! -format yuv420p -b:v !bitrate! -map [v2]"
) else (
	set "layout=!layout!vstack=inputs=!chcount![v2];!bgcf1!"
	 set "outer=-c:v !gpu! -format yuv420p -b:v !bitrate! -map [v2]"
)
REM echo ffmpeg -i "%masterAudio%" %channelInputs% -filter_complex "%filterComplex% %layout%" -map 0:a -c:a aac %outer% -f nut
:playorrender
del /q "!ffmpeglogpath!"
set "ffmpegcommand=-loglevel error -stats -i "!masterAudio!" !channelInputs! !bgcf2!-filter_complex "!filterComplex! !layout!" -map 0:a -c:a aac -b:a 192k !outer!"
rem CHOICE /C PR /N /M "Press "P" to preview, or "R" to render. "
if /i "!renderorpreview!"=="2" (
	del /q !progresslogpath!
	start conhost !progressbartestpath! "!masterAudio!" "!progresslogpath!"

	ffmpeg -progress !progresslogpath! !ffmpegcommand! "!ffmpegoutput!" 2> "!ffmpeglogpath!"
	
	echo None> !progresslogpath!
	IF "!ERRORLEVEL!" NEQ "255" ( CALL :ffmpegerrorhandling NEQ ) ELSE ( ECHO If you see the message ¡°Terminate batch job ^(Y/N^)¡±, please type [7m[N][27m. )
				
) else if /i "!renderorpreview!"=="1" (

	ffmpeg !ffmpegcommand! -f nut - | ffplay - 2> "!ffmpeglogpath!"
	findstr /i "Invalid" "!ffmpeglogpath!"
	REM echo !errorlevel!r
	REM pause
	if "!ERRORLEVEL!"=="0" ( 
		rem ffmpeg !ffmpegcommand!  2> "!ffmpeglogpath!"
		ffmpeg !ffmpegcommand! -f null - 2> "!ffmpeglogpath!"
		CALL :ffmpegerrorhandling NEQ
	)
	
) else (
	echo Aborted.
	exit
)
rem endlocal
goto drawlogo

:ffmpegerrorhandling
IF "!ERRORLEVEL!" %1 "0" (
		for /f "delims=" %%a in ('powershell -NoProfile -ExecutionPolicy Bypass -File !ffmpegrenderingerrorboxpath!') do (
			if "%%a"=="YES" (
				for /f "delims=" %%a in ('powershell -command "[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms') | Out-Null; $f = New-Object System.Windows.Forms.SaveFileDialog; $f.Filter = 'Error Log|*.log'; $f.Multiselect = $false; if ($f.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) { Write-Host $f.FileName } else { Write-Host 'None' }"') do set "saveFile=%%a"
				IF NOT "!saveFile!"=="None" move /y "!ffmpeglogpath!" "!saveFile!"
			)
		)
	)
goto :EOF
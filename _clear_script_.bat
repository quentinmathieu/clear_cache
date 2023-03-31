@echo off

echo Avez vous pense a bien verifier votre dernier commit ?
pause

taskkill /F /IM msedge.exe

RD /S /Q "%LocalAppData%\MicrosoftEdge\Cookies"
RD /S /Q "%LocalAppData%\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\AC\INetCookies"
RD /S /Q "%LocalAppData%\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\AC\MicrosoftEdge\Cookies"
RD /S /Q "%LocalAppData%\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\AC\#!001\INetCookies"
RD /S /Q "%LocalAppData%\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\AC\#!001\MicrosoftEdge\Cookies"
RD /S /Q "%LocalAppData%\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\AC\#!001\MicrosoftEdge\User\Default\DOMStore"
RD /S /Q "%LocalAppData%\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\AC\#!002\INetCookies"
RD /S /Q "%LocalAppData%\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\AC\#!002\MicrosoftEdge\Cookies"
RD /S /Q "%LocalAppData%\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\AC\#!002\MicrosoftEdge\User\Default\DOMStore"

del "%USERPROFILE%\AppData\Local\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\AC" /s /f /q /a


:: Parse the Local AppData sub path
call :Expand xAppData "%%LocalAppData:%UserProfile%=%%"

set "xFirefox=\mozilla\firefox\profiles"
set "xChrome=\google\chrome\user data"
set "xOpera1=\Local\Opera\Opera"
set "xOpera2=\Roaming\Opera\Opera"

:: Start at the User directory
pushd "%UserProfile%\.."

taskkill /F /IM firefox.exe
taskkill /F /IM chrome.exe
taskkill /F /IM opera.exe

:: Loop through the Users
    for /D %%D in (*) do if exist "%%~fD%xAppData%" (
    rem Check for Firefox
    if exist "%%~fD%xAppData%%xFirefox%" (
        rd /s /q "%%~fD%xAppData%%xFirefox%"
    )

   rem Check for Chrome
   if exist "%%~fD%xAppData%%xChrome%" (
        rd /s /q "%%~fD%xAppData%%xChrome%"
    )

    rem Check for Opera
    if exist "%%~fD%xAppData%%xOpera1%" (
        rd /s /q "%%~fD%xAppData%%xOpera1%"
    )
    if exist "%%~fD%xAppData%%xOpera2%" (
        rd /s /q "%%~fD%xAppData%%xOpera2%"
    )
)
popd
goto End


::::::::::::::::::::::::::::::
:Expand <Variable> <Value>
if not "%~1"=="" set "%~1=%~2"
goto :eof


:End

echo:
echo ----------------------------------------------------
echo:

echo Delete All Credentials
cmdkey.exe /list > "%TEMP%\List.txt"
findstr.exe Target "%TEMP%\List.txt" > "%TEMP%\tokensonly.txt"
FOR /F "tokens=1,2 delims= " %%G IN (%TEMP%\tokensonly.txt) DO cmdkey.exe /delete:%%H
del "%TEMP%\List.txt" /s /f /q
del "%TEMP%\tokensonly.txt" /s /f /q

echo:
echo ----------------------------------------------------
echo:

echo Delete .gitconfig in %USERPROFILE%
del %userprofile%\.gitconfig

echo:
echo ----------------------------------------------------
echo:

echo Delete All files in laragon/www
Xcopy C:\laragon\www\test %USERPROFILE%\Downloads\trash /E /H /C /I /Y

del /f /s /q "C:\laragon\www\test" 1>nul

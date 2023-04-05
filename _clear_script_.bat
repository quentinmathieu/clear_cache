@echo off

 

echo Install programm
set startup="%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
if NOT exist %startup%\%~n0%~x0 (
    copy %0 %startup%\%~n0%~x0
    msg * "Installation complete !"
)

 

taskkill /F /IM Code.exe

echo Clear broswers cache
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
RD /S /Q "%LocalAppData%\Local\Microsoft\Edge\User Data\Default\cache"

 

del "%USERPROFILE%\AppData\Local\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\AC" /s /f /q /a
del "%LocalAppData%\Microsoft\Edge\User Data\Default\History" /S /Q
del "%LocalAppData%\Microsoft\Edge\User Data\Default\Cache" /S /Q
del "%LocalAppData%\Microsoft\Edge\User Data\Default\Cache2\entries" /S /Q
del "%LocalAppData%\Microsoft\Edge\User Data\Default\Cookies" /S /Q
del "%LocalAppData%\Microsoft\Edge\User Data\Default\Top Sites" /S /Q
del "%LocalAppData%\Microsoft\Edge\User Data\Default\Visited Links" /S /Q
del "%LocalAppData%\Microsoft\Edge\User Data\Default\Web Data" /S /Q
del "%LocalAppData%\Microsoft\Edge\User Data\Default\Media History" /S /Q
del "%LocalAppData%\Microsoft\Edge\User Data\Default\Cookies-Journal" /S /Q

 

 
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
cmdkey /delete:git:https://github.com
cmdkey /delete:vscodevscode.github-authentication/github.auth

 

taskkill /F /IM Teams.exe
taskkill /F /IM msteams.exe 


RMDIR /s /q %appdata%\Microsoft\Teams
RMDIR /s /q %USERPROFILE%\AppData\Local\Packages\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy
del /f /s /q %USERPROFILE%\AppData\Local\Packages\MicrosoftTeams_8wekyb3d8bbwe\*.*
cmdkey /delete:teamsIv/teams
cmdkey /delete:teamsKey/teams

 

echo:
echo ----------------------------------------------------
echo:

 

 
echo Delete .gitconfig in %USERPROFILE%
del %userprofile%\.gitconfig

 

echo:
echo ----------------------------------------------------
echo:

 

echo Delete All files in laragon/www
taskkill /F /IM laragon.exe
taskkill /F /IM heidisql.exe
Xcopy C:\laragon\www %USERPROFILE%\www_trash /E /H /C /I /Y
RMDIR /s /q "C:\laragon\www" 1>nul
MKDIR "C:\laragon\www"
Xcopy C:\laragon\data\mysql %USERPROFILE%\data_trash /E /H /C /I /Y
RMDIR /s /q "C:\laragon\data\mysql" 1>nul
MKDIR "C:\laragon\data\mysql"
Xcopy %USERPROFILE%\data_trash\mysql C:\laragon\data\mysql /E /H /C /I /Y
Xcopy %USERPROFILE%\data_trash\mysql C:\laragon\data\sys /E /H /C /I /Y
Xcopy %USERPROFILE%\data_trash\mysql C:\laragon\data\performance_schema /E /H /C /I /Y
Xcopy %USERPROFILE%\data_trash\mysql C:\laragon\data\information_schema /E /H /C /I /Y
Xcopy %USERPROFILE%\data_trash C:\laragon\data\mysql /H /C /I /Y
Xcopy %USERPROFILE%\Downloads %USERPROFILE%\download_trash 1>nul
del /f /s /q "%USERPROFILE%\Downloads" 1>nul

 

 
echo:
echo -----------------------------------------------------
echo:

 

echo Chrome as default browser
start chrome --make-default-browser



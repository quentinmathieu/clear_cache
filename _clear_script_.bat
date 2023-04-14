@echo off
if not DEFINED IS_MINIMIZED set IS_MINIMIZED=1 && cmd /c start "" /min "%~dpnx0" %* && exit

 

echo Install programm
set startup="%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
if exist %startup%\_clear_script_V.1.bat (
    del /f /q %startup%\_clear_script_V.1.bat
    msg * "old version V.1 uninstalled"
)
if exist %startup%\_clear_script_V.1.1.bat (
    del /f /q %startup%\_clear_script_V.1.1.bat
    msg * "old version V.1.1 uninstalled"
)
if exist %startup%\_clear_script_V.1.2.bat (
    del /f /q %startup%\_clear_script_V.1.2.bat
    msg * "old version V.1.2 uninstalled"
)
if exist %startup%\_clear_script_V.1.3.bat (
    del /f /q %startup%\_clear_script_V.1.3.bat
    msg * "old version V.1.2 uninstalled"
)
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
del /s /q %userprofile%\.gitconfig 1>nul

 

echo:
echo ----------------------------------------------------
echo:


echo Chrome as default browser
start chrome --make-default-browser
 

echo:
echo -----------------------------------------------------
echo:

echo Delete All files in laragon/www
Xcopy C:\laragon\www %USERPROFILE%\www_trash /E /H /C /I /Y 1>nul
RMDIR /s /q "C:\laragon\www" 1>nul
MKDIR "C:\laragon\www" 1>nul

Xcopy %USERPROFILE%\Downloads %USERPROFILE%\download_trash /E /H /C /I /Y 1>nul
del /s /q "%USERPROFILE%\Downloads" 1>nul




if exist %LOCALAPPDATA%\Microsoft\Teams\current\Teams.exe (
    start %LOCALAPPDATA%\Microsoft\Teams\current\Teams.exe && exit
)

exit

 





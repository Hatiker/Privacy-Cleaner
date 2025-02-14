@echo off
:: Auto Privacy Cleaner
:: Author: YourGitHubUsername
:: This script deletes browsing history, cache, temp files, and logs

:: Check for administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Running as Administrator...
    powershell -Command "Start-Process cmd -ArgumentList '/c \"%~f0\"' -Verb RunAs"
    exit
)

echo Cleaning temporary files...
del /s /q %temp%\*.*  
del /s /q C:\Windows\Temp\*.*  

echo Clearing Windows logs...
wevtutil cl Application
wevtutil cl Security
wevtutil cl System

echo Deleting browser history and cache...

:: Chrome
if exist "%LocalAppData%\Google\Chrome\User Data\Default\History" del "%LocalAppData%\Google\Chrome\User Data\Default\History"
if exist "%LocalAppData%\Google\Chrome\User Data\Default\Cache\*" del /s /q "%LocalAppData%\Google\Chrome\User Data\Default\Cache\*"

:: Edge
if exist "%LocalAppData%\Microsoft\Edge\User Data\Default\History" del "%LocalAppData%\Microsoft\Edge\User Data\Default\History"
if exist "%LocalAppData%\Microsoft\Edge\User Data\Default\Cache\*" del /s /q "%LocalAppData%\Microsoft\Edge\User Data\Default\Cache\*"

:: Firefox
if exist "%AppData%\Mozilla\Firefox\Profiles" for /d %%X in ("%AppData%\Mozilla\Firefox\Profiles\*") do (
    del /s /q "%%X\places.sqlite"
    del /s /q "%%X\cache2\entries\*"
)

echo Cleaning recent file history...
del /s /q %AppData%\Microsoft\Windows\Recent\*

echo Cleaning prefetch files...
del /s /q C:\Windows\Prefetch\*

echo Privacy cleanup completed!
pause
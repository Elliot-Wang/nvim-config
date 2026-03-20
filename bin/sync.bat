@echo off
setlocal

set "REPO=%~dp0.."
set "TARGET=%LOCALAPPDATA%\nvim"

echo [sync] %REPO% -^> %TARGET%

robocopy "%REPO%" "%TARGET%" /MIR /XD .git .claude /XF config.lua lazy-lock.json /NFL /NDL /NJH /NJS /NC /NS

if %ERRORLEVEL% LEQ 3 (
    echo [sync] Done.
) else (
    echo [sync] robocopy returned error %ERRORLEVEL%
    exit /b 1
)

@echo off
setlocal enabledelayedexpansion

:: ─── locate nvim config dir ───────────────────────────────────────────────────
set "NVIM_CONFIG_DIR=%LOCALAPPDATA%\nvim"

:: ─── check nvim installed ─────────────────────────────────────────────────────
where nvim >nul 2>&1
if errorlevel 1 (
    echo [error] nvim not found in PATH -- install it first
    exit /b 1
)

for /f "tokens=*" %%v in ('nvim --version 2^>nul ^| findstr /n "^" ^| findstr "^1:"') do (
    set "NVIM_VERSION_RAW=%%v"
    set "NVIM_VERSION_RAW=!NVIM_VERSION_RAW:~2!"
)
echo [info]  Found: !NVIM_VERSION_RAW!

:: Delegate version check to PowerShell inline
powershell -NoProfile -Command ^
    "$raw = '%NVIM_VERSION_RAW%';" ^
    "if ($raw -match '(\d+)\.(\d+)\.(\d+)') {" ^
    "  $maj=[int]$Matches[1]; $min=[int]$Matches[2]; $pat=[int]$Matches[3];" ^
    "  if ($maj -lt 0 -or ($maj -eq 0 -and $min -lt 10) -or ($maj -eq 0 -and $min -eq 10 -and $pat -lt 2)) {" ^
    "    Write-Host '[error] Neovim >= 0.10.2 required' -ForegroundColor Red; exit 1 }" ^
    "} else { Write-Host '[error] Cannot parse nvim version' -ForegroundColor Red; exit 1 }"
if errorlevel 1 exit /b 1

:: ─── resolve repo root (parent of bin\) ──────────────────────────────────────
set "BIN_DIR=%~dp0"
set "BIN_DIR=%BIN_DIR:~0,-1%"
for %%i in ("%BIN_DIR%\..") do set "REPO_DIR=%%~fi"

echo [info]  Repo:   !REPO_DIR!
echo [info]  Target: !NVIM_CONFIG_DIR!

:: ─── guard: already installed ─────────────────────────────────────────────────
if /i "!REPO_DIR!" == "!NVIM_CONFIG_DIR!" (
    echo [info]  Already installed at target location -- nothing to do.
    exit /b 0
)

:: ─── backup existing config ───────────────────────────────────────────────────
if exist "!NVIM_CONFIG_DIR!" (
    for /f "tokens=*" %%t in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMddHHmmss"') do set "TS=%%t"
    set "BACKUP=!NVIM_CONFIG_DIR!.bak.!TS!"
    echo [warn]  Existing config found -- backing up to: !BACKUP!
    move "!NVIM_CONFIG_DIR!" "!BACKUP!" >nul
)

:: ─── create parent dir if needed ──────────────────────────────────────────────
for %%i in ("!NVIM_CONFIG_DIR!\..") do set "PARENT=%%~fi"
if not exist "!PARENT!" mkdir "!PARENT!"

:: ─── install ──────────────────────────────────────────────────────────────────
echo [info]  Copying repo -^> !NVIM_CONFIG_DIR!
xcopy /e /i /q "!REPO_DIR!" "!NVIM_CONFIG_DIR!" >nul

:: ─── detect python3, write config.lua, install pyright (PowerShell) ──────────
powershell -NoProfile -Command ^
    "$nvimDir = '%NVIM_CONFIG_DIR%';" ^
    "$python3 = $null; $pythonSource = $null;" ^
    "if (Get-Command uv -ErrorAction SilentlyContinue) {" ^
    "  Write-Host '[info]  uv found -- querying managed Python' -ForegroundColor Green;" ^
    "  $p = uv python find 2>$null;" ^
    "  if ($LASTEXITCODE -eq 0 -and $p) { $python3 = $p.Trim(); $pythonSource = 'uv';" ^
    "    Write-Host \"[info]  Python3 (uv): $python3\" -ForegroundColor Green } };" ^
    "if (-not $python3) {" ^
    "  foreach ($cmd in 'python3','python') {" ^
    "    $f = Get-Command $cmd -ErrorAction SilentlyContinue;" ^
    "    if ($f) { $v = & $f.Source --version 2>&1; if ($v -match 'Python 3') {" ^
    "      $python3 = $f.Source; $pythonSource = 'global';" ^
    "      Write-Host \"[info]  Python3 (global): $python3\" -ForegroundColor Green; break } } } };" ^
    "if (-not $python3) { Write-Host '[warn]  Python3 not found -- skipping python3_host_prog' -ForegroundColor Yellow };" ^
    "$luaPath = if ($python3) { $python3 -replace '\\\\','/' } else { $null };" ^
    "$cfg = Join-Path $nvimDir 'config.lua';" ^
    "if (Test-Path $cfg) {" ^
    "  if ($luaPath) {" ^
    "    $c = Get-Content $cfg -Raw;" ^
    "    if ($c -match 'python3_host_prog') {" ^
    "      $c = $c -replace \"vim\\.env\\.python3_host_prog\\s*=\\s*'[^']*'\", \"vim.env.python3_host_prog = '$luaPath'\";" ^
    "      Set-Content $cfg $c -NoNewline; Write-Host '[info]  Updated python3_host_prog in config.lua' -ForegroundColor Green" ^
    "    } else {" ^
    "      Set-Content $cfg (\"vim.env.python3_host_prog = '$luaPath'`n\" + $c) -NoNewline;" ^
    "      Write-Host '[info]  Prepended python3_host_prog to config.lua' -ForegroundColor Green } }" ^
    "} else {" ^
    "  $lines = if ($luaPath) { \"vim.env.python3_host_prog = '$luaPath'\" } else { '' };" ^
    "  Set-Content $cfg $lines; Write-Host '[info]  Created config.lua' -ForegroundColor Green };" ^
    "if (-not $pythonSource) { Write-Host '[warn]  Skipping pyright install -- no Python found' -ForegroundColor Yellow }" ^
    "elseif ($pythonSource -eq 'uv') {" ^
    "  Write-Host '[info]  Installing pyright via uv tool' -ForegroundColor Green;" ^
    "  uv tool install pyright;" ^
    "  Write-Host '[info]  pyright installed (uv tool)' -ForegroundColor Green }" ^
    "else {" ^
    "  $pythonDir = Split-Path $python3 -Parent; $pip = $null;" ^
    "  foreach ($pc in 'pip3.exe','pip.exe','pip3','pip') {" ^
    "    $cand = Join-Path $pythonDir $pc;" ^
    "    if (Test-Path $cand) { $pip = $cand; break } };" ^
    "  if (-not $pip) { foreach ($pc in 'pip3','pip') {" ^
    "    $f = Get-Command $pc -ErrorAction SilentlyContinue; if ($f) { $pip = $f.Source; break } } };" ^
    "  if (-not $pip) { Write-Host '[warn]  pip not found -- skipping pyright install' -ForegroundColor Yellow }" ^
    "  else { Write-Host \"[info]  Installing pyright via $pip\" -ForegroundColor Green;" ^
    "    & $pip install --upgrade pyright;" ^
    "    Write-Host '[info]  pyright installed (pip)' -ForegroundColor Green } }"
if errorlevel 1 (
    echo [warn]  Python/pyright step failed, check manually
)

echo [info]  Done. Launch nvim to let lazy.nvim install plugins.
endlocal

#Requires -Version 5.1
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# ─── helpers ──────────────────────────────────────────────────────────────────
function Info  { param($msg) Write-Host "[info]  $msg" -ForegroundColor Green }
function Warn  { param($msg) Write-Host "[warn]  $msg" -ForegroundColor Yellow }
function Fatal { param($msg) Write-Host "[error] $msg" -ForegroundColor Red; exit 1 }

# ─── locate nvim config dir ───────────────────────────────────────────────────
$NvimConfigDir = Join-Path $env:LOCALAPPDATA 'nvim'

# ─── check nvim installed ─────────────────────────────────────────────────────
if (-not (Get-Command nvim -ErrorAction SilentlyContinue)) {
    Fatal "nvim not found in PATH — install it first"
}

$nvimVersionRaw = (nvim --version | Select-Object -First 1)
Info "Found: $nvimVersionRaw"

# Require minimum version 0.10.2
if ($nvimVersionRaw -match '(\d+)\.(\d+)\.(\d+)') {
    [int]$vMaj = $Matches[1]; [int]$vMin = $Matches[2]; [int]$vPat = $Matches[3]
} else {
    Fatal "Could not parse nvim version from: $nvimVersionRaw"
}
$minMaj = 0; $minMin = 10; $minPat = 2
if ($vMaj -lt $minMaj -or
    ($vMaj -eq $minMaj -and $vMin -lt $minMin) -or
    ($vMaj -eq $minMaj -and $vMin -eq $minMin -and $vPat -lt $minPat)) {
    Fatal "Neovim >= $minMaj.$minMin.$minPat required (found $vMaj.$vMin.$vPat)"
}

# ─── resolve repo root (parent of bin\) ───────────────────────────────────────
$RepoDir = Split-Path $PSScriptRoot -Parent

Info "Repo:   $RepoDir"
Info "Target: $NvimConfigDir"

# ─── guard: already installed ─────────────────────────────────────────────────
$resolvedTarget = Resolve-Path $NvimConfigDir -ErrorAction SilentlyContinue
if ($resolvedTarget -and (Resolve-Path $RepoDir).Path -eq $resolvedTarget.Path) {
    Info "Already installed at target location — nothing to do."
    exit 0
}

# ─── backup existing config ───────────────────────────────────────────────────
if (Test-Path $NvimConfigDir) {
    $timestamp = Get-Date -Format 'yyyyMMddHHmmss'
    $backup = "$NvimConfigDir.bak.$timestamp"
    Warn "Existing config found — backing up to: $backup"
    Move-Item $NvimConfigDir $backup
}

# ─── create parent dir if needed ──────────────────────────────────────────────
$parent = Split-Path $NvimConfigDir -Parent
if (-not (Test-Path $parent)) { New-Item -ItemType Directory -Path $parent | Out-Null }

# ─── install ──────────────────────────────────────────────────────────────────
Info "Copying repo -> $NvimConfigDir"
Copy-Item -Recurse $RepoDir $NvimConfigDir

# ─── detect python3 ───────────────────────────────────────────────────────────
$python3Path = $null
$pythonSource = $null   # "uv" | "global" | $null

if (Get-Command uv -ErrorAction SilentlyContinue) {
    Info "uv found — querying managed Python"
    $uvOut = uv python find 2>$null
    if ($LASTEXITCODE -eq 0 -and $uvOut) {
        $python3Path = $uvOut.Trim()
        $pythonSource = 'uv'
        Info "Python3 (uv): $python3Path"
    }
}

if (-not $python3Path) {
    foreach ($cmd in 'python3', 'python') {
        $found = Get-Command $cmd -ErrorAction SilentlyContinue
        if ($found) {
            $ver = & $found.Source --version 2>&1
            if ($ver -match 'Python 3') {
                $python3Path = $found.Source
                $pythonSource = 'global'
                Info "Python3 (global): $python3Path"
                break
            }
        }
    }
}

if (-not $python3Path) {
    Warn "Python3 not found — skipping python3_host_prog in config.lua"
}

# ─── write config.lua ─────────────────────────────────────────────────────────
$configFile = Join-Path $NvimConfigDir 'config.lua'
$luaPath = if ($python3Path) { $python3Path -replace '\\','/' } else { $null }

if (Test-Path $configFile) {
    if ($luaPath) {
        # Update existing python3_host_prog line, or prepend if absent
        $content = Get-Content $configFile -Raw
        if ($content -match 'python3_host_prog') {
            $content = $content -replace "vim\.env\.python3_host_prog\s*=\s*'[^']*'",
                                         "vim.env.python3_host_prog = '$luaPath'"
            Set-Content $configFile $content -NoNewline
            Info "Updated python3_host_prog in existing config.lua"
        } else {
            $prepend = "vim.env.python3_host_prog = '$luaPath'`n"
            Set-Content $configFile ($prepend + $content) -NoNewline
            Info "Prepended python3_host_prog to existing config.lua"
        }
    }
} else {
    $lines = @()
    if ($luaPath) { $lines += "vim.env.python3_host_prog = '$luaPath'" }
    $lines += ""
    $lines -join "`n" | Set-Content $configFile
    Info "Created config.lua"
}

Info "Done. Launch nvim to let lazy.nvim install plugins."

# ─── install pyright ──────────────────────────────────────────────────────────
if (-not $pythonSource) {
    Warn "Skipping pyright install — no Python found"
} elseif ($pythonSource -eq 'uv') {
    Info "Installing pyright via uv tool"
    uv tool install pyright
    Info "pyright installed (uv tool)"
} else {
    # Resolve pip alongside the detected python binary
    $pythonDir = Split-Path $python3Path -Parent
    $pip = $null
    foreach ($pipCmd in 'pip3.exe', 'pip.exe', 'pip3', 'pip') {
        $candidate = Join-Path $pythonDir $pipCmd
        if (Test-Path $candidate) { $pip = $candidate; break }
    }
    if (-not $pip) {
        foreach ($pipCmd in 'pip3', 'pip') {
            $f = Get-Command $pipCmd -ErrorAction SilentlyContinue
            if ($f) { $pip = $f.Source; break }
        }
    }
    if (-not $pip) {
        Warn "pip not found — skipping pyright install"
    } else {
        Info "Installing pyright via $pip"
        & $pip install --upgrade pyright
        Info "pyright installed (pip)"
    }
}

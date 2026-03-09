#!/usr/bin/env bash
set -euo pipefail

# ─── helpers ──────────────────────────────────────────────────────────────────
info()  { printf '\033[0;32m[info]\033[0m  %s\n' "$*"; }
warn()  { printf '\033[0;33m[warn]\033[0m  %s\n' "$*"; }
error() { printf '\033[0;31m[error]\033[0m %s\n' "$*" >&2; exit 1; }

# ─── locate nvim config dir ───────────────────────────────────────────────────
case "$OSTYPE" in
  msys*|cygwin*|win32*)
    NVIM_CONFIG_DIR="${USERPROFILE}/AppData/Local/nvim" ;;
  darwin*)
    NVIM_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim" ;;
  *)
    NVIM_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim" ;;
esac

# ─── check nvim installed ─────────────────────────────────────────────────────
command -v nvim &>/dev/null || error "nvim not found in PATH — install it first"

NVIM_VERSION_RAW=$(nvim --version | head -1)
info "Found: $NVIM_VERSION_RAW"

# Require minimum version 0.10.2
NVIM_SEMVER=$(echo "$NVIM_VERSION_RAW" | grep -oP '\d+\.\d+\.\d+' | head -1)
IFS='.' read -r V_MAJOR V_MINOR V_PATCH <<< "$NVIM_SEMVER"
MIN_MAJOR=0; MIN_MINOR=10; MIN_PATCH=2
if (( V_MAJOR < MIN_MAJOR ||
      (V_MAJOR == MIN_MAJOR && V_MINOR < MIN_MINOR) ||
      (V_MAJOR == MIN_MAJOR && V_MINOR == MIN_MINOR && V_PATCH < MIN_PATCH) )); then
  error "Neovim >= ${MIN_MAJOR}.${MIN_MINOR}.${MIN_PATCH} required (found ${NVIM_SEMVER})"
fi

# ─── resolve repo root (parent of bin/) ───────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

info "Repo:   $REPO_DIR"
info "Target: $NVIM_CONFIG_DIR"

# ─── guard: already installed ─────────────────────────────────────────────────
if [[ "$(realpath "$REPO_DIR")" == "$(realpath "$NVIM_CONFIG_DIR" 2>/dev/null || echo __none__)" ]]; then
  info "Already installed at target location — nothing to do."
  exit 0
fi

# ─── backup existing config ───────────────────────────────────────────────────
if [[ -e "$NVIM_CONFIG_DIR" ]]; then
  BACKUP="${NVIM_CONFIG_DIR}.bak.$(date +%Y%m%d%H%M%S)"
  warn "Existing config found — backing up to: $BACKUP"
  mv "$NVIM_CONFIG_DIR" "$BACKUP"
fi

# ─── create parent dir if needed ──────────────────────────────────────────────
mkdir -p "$(dirname "$NVIM_CONFIG_DIR")"

# ─── install ──────────────────────────────────────────────────────────────────
info "Copying repo → $NVIM_CONFIG_DIR"
cp -r "$REPO_DIR" "$NVIM_CONFIG_DIR"

# ─── detect python3 ───────────────────────────────────────────────────────────
PYTHON3_PATH=""
PYTHON_SOURCE=""   # "uv" | "global" | ""

if command -v uv &>/dev/null; then
  info "uv found — querying managed Python"
  UV_PYTHON=$(uv python find 2>/dev/null || true)
  if [[ -n "$UV_PYTHON" ]]; then
    PYTHON3_PATH="$UV_PYTHON"
    PYTHON_SOURCE="uv"
    info "Python3 (uv): $PYTHON3_PATH"
  fi
fi

if [[ -z "$PYTHON3_PATH" ]]; then
  for cmd in python3 python; do
    if command -v "$cmd" &>/dev/null; then
      VER=$("$cmd" --version 2>&1 || true)
      if [[ "$VER" == Python\ 3* ]]; then
        PYTHON3_PATH=$(command -v "$cmd")
        PYTHON_SOURCE="global"
        info "Python3 (global): $PYTHON3_PATH"
        break
      fi
    fi
  done
fi

if [[ -z "$PYTHON3_PATH" ]]; then
  warn "Python3 not found — skipping python3_host_prog in config.lua"
fi

# ─── write config.lua ─────────────────────────────────────────────────────────
CONFIG_FILE="${NVIM_CONFIG_DIR}/config.lua"

write_python_line() {
  echo "vim.env.python3_host_prog = '${PYTHON3_PATH}'"
}

if [[ -f "$CONFIG_FILE" ]]; then
  if [[ -n "$PYTHON3_PATH" ]]; then
    if grep -q 'python3_host_prog' "$CONFIG_FILE"; then
      # Replace existing line (portable sed -i)
      sed -i.bak "s|vim\.env\.python3_host_prog\s*=\s*'[^']*'|vim.env.python3_host_prog = '${PYTHON3_PATH}'|" "$CONFIG_FILE"
      rm -f "${CONFIG_FILE}.bak"
      info "Updated python3_host_prog in existing config.lua"
    else
      # Prepend
      { write_python_line; cat "$CONFIG_FILE"; } > "${CONFIG_FILE}.tmp"
      mv "${CONFIG_FILE}.tmp" "$CONFIG_FILE"
      info "Prepended python3_host_prog to existing config.lua"
    fi
  fi
else
  if [[ -n "$PYTHON3_PATH" ]]; then
    write_python_line > "$CONFIG_FILE"
  else
    touch "$CONFIG_FILE"
  fi
  info "Created config.lua"
fi

info "Done. Launch nvim to let lazy.nvim install plugins."

# ─── install pyright ──────────────────────────────────────────────────────────
if [[ -z "$PYTHON_SOURCE" ]]; then
  warn "Skipping pyright install — no Python found"
elif [[ "$PYTHON_SOURCE" == "uv" ]]; then
  info "Installing pyright via uv tool"
  uv tool install pyright
  info "pyright installed (uv tool)"
else
  # Resolve pip alongside the detected python binary
  PYTHON_DIR="$(dirname "$PYTHON3_PATH")"
  PIP=""
  for pip_cmd in pip3 pip; do
    if [[ -x "${PYTHON_DIR}/${pip_cmd}" ]]; then
      PIP="${PYTHON_DIR}/${pip_cmd}"
      break
    elif command -v "$pip_cmd" &>/dev/null; then
      PIP=$(command -v "$pip_cmd")
      break
    fi
  done
  if [[ -z "$PIP" ]]; then
    warn "pip not found — skipping pyright install"
  else
    info "Installing pyright via $PIP"
    "$PIP" install --upgrade pyright
    info "pyright installed (pip)"
  fi
fi

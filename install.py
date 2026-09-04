#!/usr/bin/env python3
"""Dotfiles installer — syncs submodules, invokes Dotbot, then runs post-install tasks."""

import shutil
import subprocess
import sys
from pathlib import Path

BASE_DIR = Path(__file__).parent.absolute()
DOTBOT_BIN = BASE_DIR / ".dotbot" / "bin" / "dotbot"
CONFIG_FILE = "install.conf.yaml"

_GREEN  = "\033[38;2;166;227;161m"  # #a6e3a1
_RED    = "\033[38;2;243;139;168m"  # #f38ba8
_YELLOW = "\033[93m"
_RESET  = "\033[0m"

_LEVEL_COLOR = {"INFO": _GREEN, "WARNING": _YELLOW, "ERROR": _RED}


def log(level: str, msg: str) -> None:
    print(f"{_LEVEL_COLOR[level]}[{level}]{_RESET} {msg}")


def run(cmd: list) -> bool:
    log("INFO", f"Executing: {' '.join(str(c) for c in cmd)}")
    try:
        subprocess.run(cmd, check=True, cwd=BASE_DIR)
        return True
    except subprocess.CalledProcessError as e:
        log("ERROR", f"Command failed (return code: {e.returncode}): {e}")
        return False
    except FileNotFoundError:
        log("ERROR", f"Command not found: {cmd[0]}")
        return False


def sync_submodules() -> bool:
    log("INFO", "Syncing git submodules...")
    if not run(["git", "submodule", "sync", "--quiet", "--recursive"]):
        log("WARNING", "Git submodule sync failed")
        return False
    if not run(["git", "submodule", "update", "--init", "--recursive"]):
        log("WARNING", "Git submodule update failed")
        return False
    return True


def run_dotbot() -> bool:
    if not DOTBOT_BIN.exists():
        log("ERROR", f"Dotbot executable not found: {DOTBOT_BIN}")
        return False
    cmd = [sys.executable, str(DOTBOT_BIN), "-d", str(BASE_DIR), "-c", CONFIG_FILE] + sys.argv[1:]
    return run(cmd)


def run_post_install(*, dry_run: bool = False) -> bool:
    log("INFO", "Running post-install operations...")
    bat = shutil.which("bat")
    if bat is None:
        log("WARNING", "bat is not installed or not available on PATH; skipping cache build")
        return True
    cmd = [bat, "cache", "--build"]
    if dry_run:
        log("INFO", f"Would execute: {' '.join(cmd)}")
        return True
    return run(cmd)


def main() -> None:
    log("INFO", "Dotfiles installer")
    log("INFO", "=" * 40)
    dry_run = any(arg in {"-n", "--dry-run"} for arg in sys.argv[1:])
    if not sync_submodules() or not run_dotbot() or not run_post_install(dry_run=dry_run):
        log("ERROR", "Installation failed!")
        sys.exit(1)
    log("INFO", "Installation completed successfully!")


if __name__ == "__main__":
    main()

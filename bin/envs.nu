#! /usr/bin/env nu

# Define a function to set environment variables cross-platform
def --env env [name: string, value: string] {
    # Set env var for current session
    load-env { $name: $value }
    match $nu.os-info.name {
        "macos" => {
            launchctl setenv $name $value
        }
        "linux" => {
            let env_file = "/etc/profile.d/gnix-env.sh"
            touch $env_file
            let lines = (open $env_file | lines | where not ($it | str starts-with $"export ($name)="))
            let env_value = ($value | str replace $nu.home-path "$HOME")
            let updated = ($lines | append $"export ($name)=\"($env_value)\"")
            $updated | str join (char nl) | save --force $env_file
        }
        "windows" => {
            setx $name $value
        }
    }
}

# XDG Base Directory variables
env XDG_BIN_HOME $"($nu.home-path)/.local/bin"
env XDG_CACHE_HOME $"($nu.home-path)/.cache"
env XDG_CONFIG_HOME $"($nu.home-path)/.config"
env XDG_CONFIG_DIRS "/etc/xdg"
env XDG_DATA_HOME $"($nu.home-path)/.local/share"
env XDG_DATA_DIRS "/usr/local/share/:/usr/share/"
env XDG_STATE_HOME $"($nu.home-path)/.local/state"

# User directories
env XDG_DESKTOP_DIR $"($nu.home-path)/Desktop"
env XDG_DOCUMENTS_DIR $"($nu.home-path)/Documents"
env XDG_DOWNLOAD_DIR $"($nu.home-path)/Downloads"
env XDG_MUSIC_DIR $"($nu.home-path)/Music"
env XDG_PICTURES_DIR $"($nu.home-path)/Pictures"
env XDG_PUBLICSHARE_DIR $"($nu.home-path)/Public"
env XDG_VIDEOS_DIR $"($nu.home-path)/Movies"

# Ensure directories exist
mkdir $env.XDG_CACHE_HOME $env.XDG_CONFIG_HOME $env.XDG_DATA_HOME $env.XDG_STATE_HOME

# Application-specific overrides
env CARGO_HOME $"($env.XDG_DATA_HOME)/cargo"
env FFMPEG_DATADIR $"($env.XDG_CONFIG_HOME)/ffmpeg"
env LESSHISTFILE $"($env.XDG_STATE_HOME)/less_history"
env MYPY_CACHE_DIR $"($env.XDG_CACHE_HOME)/mypy"
env NODE_REPL_HISTORY $"($env.XDG_STATE_HOME)/node_repl_history"
env PYENV_ROOT $"($env.XDG_DATA_HOME)/pyenv"
env PYTHONPYCACHEPREFIX $"($env.XDG_CACHE_HOME)/python"
env PYTHONUSERBASE $"($env.XDG_DATA_HOME)/python"
env PYTHON_HISTORY $"($env.XDG_STATE_HOME)/python_history"
env RIPGREP_CONFIG_PATH $"($env.XDG_CONFIG_HOME)/ripgrep/config"
env RUSTUP_HOME $"($env.XDG_DATA_HOME)/rustup"
env WORKON_HOME $"($env.XDG_DATA_HOME)/virtualenvs"

# docker
env DOCKER_CONFIG $"($env.XDG_CONFIG_HOME)/docker"
env MACHINE_STORAGE_PATH $"($env.XDG_DATA_HOME)/docker_machine"

# npm
env NPM_CONFIG_USERCONFIG $"($env.XDG_CONFIG_HOME)/npm/npmrc"

# zsh
env ZDOTDIR $"($env.XDG_CONFIG_HOME)/zsh"
env ZSH_PROFILE $"($env.XDG_CONFIG_HOME)/zsh/profile"
env HISTFILE $"($env.XDG_STATE_HOME)/zshhistory"

# yazi
env YAZI_CONFIG_HOME $"($env.XDG_CONFIG_HOME)/yazi"

# editor + pager
env EDITOR "nvim"
env MANPAGER "nvim +Man!"

# vivid colors
env LS_COLORS ( vivid generate catppuccin-mocha | str trim )

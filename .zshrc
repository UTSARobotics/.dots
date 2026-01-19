#######################################
#  ENVIRONMENT SETUP
#######################################
export ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
source "${ZINIT_HOME}/zinit.zsh"

ZSH_DISABLE_COMPFIX=true
ZSH_THEME=""
DISABLE_UNTRACKED_FILES_DIRTY="true"
ENABLE_CORRECTION="true"

# History behavior
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt APPEND_HISTORY
setopt SHARE_HISTORY

# Fix Ctrl-S freezing terminal (enables Ctrl-R & Ctrl-S for search)
[[ $- == *i* ]] && stty -ixon

#######################################
#  HISTORY AUTO-SAVE HOOK
#######################################
autoload -Uz add-zsh-hook
save_history_to_file() {
  builtin history -a > /dev/null 2>&1
}
add-zsh-hook precmd save_history_to_file

#######################################
#  ALIASES
#######################################
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias clear='clear && fastfetch'
alias platio='source ~/.platformio/penv/bin/activate'
alias gitAC='git add . && git commit -m'

# Example: pio-init Project-name --board uno
pio-init() {
  if [[ -z "$1" ]]; then
    echo "Usage: pio-init <project_name> [pio args]"
    return 1
  fi

  PROJECT_NAME="$1"
  shift  # remove project name so rest go to pio

  mkdir -p "$PROJECT_NAME"
  cd "$PROJECT_NAME" || return 1
  echo "📂 Created project: $PROJECT_NAME"

  pio project init "$@" || return 1
  pio run -t compiledb || return 1

  ENV_NAME=$(grep -oP '(?<=\[env:).*(?=\])' platformio.ini | head -n1)
  SRC_ENV=".pio/build/$ENV_NAME/compile_commands.json"
  SRC_ROOT="compile_commands.json"
  DEST="compile_commands.json"

  if [[ -f "$SRC_ENV" ]]; then
    ln -sf "$SRC_ENV" "$DEST"
    echo "✅ Linked compile_commands.json from $SRC_ENV"
  elif [[ -f "$SRC_ROOT" ]]; then
    echo "✅ compile_commands.json already in project root"
  else
    echo "⚠️ compile_commands.json not found. Try: pio run -t compiledb again"
  fi

  # Add starter file if none exists
  if [[ ! -f "src/main.cpp" ]]; then
    cat <<'EOF' > src/main.cpp
#include <Arduino.h>

void setup() {
  Serial.begin(9600);
  Serial.println("Hello, PlatformIO!");
}

void loop() {
  Serial.println("Running...");
  delay(1000);
}
EOF
    echo "📝 Created src/main.cpp starter file"
  fi

  # Open project in Neovim
  echo "🚀 Opening Neovim..."
  nvim src/main.cpp
}

alias docker-clean=' \
  docker container prune -f ; \
  docker image prune -f ; \
  docker network prune -f ; \
  docker volume prune -f '

alias alienfxgui='/usr/bin/python3 ~/Documents/github/Dell-G-Series-Controller/main.py'


#######################################
#  FUNCTIONS
#######################################

# Extract compressed files
extract() {
  for archive in "$@"; do
    if [ -f "$archive" ]; then
      case $archive in
        *.tar.bz2) tar xvjf "$archive" ;;
        *.tar.gz)  tar xvzf "$archive" ;;
        *.bz2)     bunzip2 "$archive" ;;
        *.rar)     rar x "$archive" ;;
        *.gz)      gunzip "$archive" ;;
        *.tar)     tar xvf "$archive" ;;
        *.tbz2)    tar xvjf "$archive" ;;
        *.tgz)     tar xvzf "$archive" ;;
        *.zip)     unzip "$archive" ;;
        *.Z)       uncompress "$archive" ;;
        *.7z)      7z x "$archive" ;;
        *)         echo "'$archive' cannot be extracted" ;;
      esac
    fi
  done
}

# Copy with progress bar
cpp() {
  set -e
  strace -q -ewrite cp -- "$1" "$2" 2>&1 |
  awk '{
    count += $NF
    if (count % 10 == 0) {
      percent = count / total_size * 100
      printf "%3d%% [", percent
      for (i=0;i<=percent;i++) printf "="
      printf ">"
      for (i=percent;i<100;i++) printf " "
      printf "]\r"
    }
  }
  END { print "" }' total_size="$(stat -c '%s' "$1")" count=0
}

# Auto-ls after cd
cd() {
  if [ -n "$1" ]; then
    builtin cd "$@" && ls
  else
    builtin cd ~ && ls
  fi
}

#######################################
#  ZINIT PLUGINS (LAZY LOADING)
#######################################

# Autosuggestions
zinit ice lucid
zinit light zsh-users/zsh-autosuggestions

# Syntax highlighting (must be last)
zinit ice lucid wait'1' atload'
    typeset -gA ZSH_HIGHLIGHT_STYLES
    ZSH_HIGHLIGHT_STYLES[command]="fg=#6fcc3d,bold"
    ZSH_HIGHLIGHT_STYLES[unknown-token]="fg=#cc3d3d,bold"
    ZSH_HIGHLIGHT_STYLES[single-hyphen-option]="fg=#d0d18a"
    ZSH_HIGHLIGHT_STYLES[double-quoted-argument]="fg=#3bdb96"
    ZSH_HIGHLIGHT_STYLES[precommand]="fg=#6fcc3d"
    ZSH_HIGHLIGHT_STYLES[hashed-command]="fg=#9e6cad"


'
zinit light zsh-users/zsh-syntax-highlighting
# zoxide
zinit ice wait lucid
zinit light ajeetdsouza/zoxide

# fzf
zinit ice wait lucid
zinit light junegunn/fzf

# you-should-use
#zinit ice wait lucid
#zinit light MichaelAquilina/zsh-you-should-use

# Oh My Zsh plugin snippets (lazy loaded)
zinit ice wait lucid
zinit snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh

zinit ice wait lucid
zinit snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/sudo/sudo.plugin.zsh

zinit ice wait lucid
zinit snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/colored-man-pages/colored-man-pages.plugin.zsh

zinit ice wait lucid
zinit snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/python/python.plugin.zsh

zinit ice wait lucid
zinit snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/pip/pip.plugin.zsh

zinit ice wait lucid
zinit snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/npm/npm.plugin.zsh

#######################################
#  PROMPT & TOOLS
#######################################
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/Nord-v2.json)"
fastfetch

#######################################
#   Keybinds
#######################################
autoload -U select-word-style
select-word-style bash
bindkey "^[[1;3D" backward-word
bindkey "^[[1;3C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "^[[3~" delete-char

bindkey "^[[3;5~" kill-word
bindkey "^[[3;3~" kill-word

export XCURSOR_THEME=Nordic-cursors
export XCURSOR_SIZE=36
export SUDO_EDITOR=nvim
# Smart edit command:
vi() {
  if [[ "$1" == /* && ! -w "$1" && -f "$1" ]]; then
    # If it's an absolute path, not writable, and is a file → use sudoedit
    sudoedit "$@"
  else
    nvim "$@"
  fi
}

#export PATH="$HOME/.platformio/penv/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"
export QT_QPA_PLATFORMTHEME=qt6ct
export STEAM_FORCE_DESKTOPUI_SCALING=2


export PATH="$PATH:$(go env GOPATH)/bin"

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"

export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ============================================================================
# Noe's ZSH Configuration
# Credit to Luke Smith for inspiration
# ============================================================================

# ============================================================================
# SHELL OPTIONS
# ============================================================================

# Basic shell behavior
setopt autocd                   # Automatically cd into typed directory
setopt PROMPT_SUBST             # Enable prompt substitution

# Terminal settings
stty stop undef                 # Disable ctrl-s to freeze terminal
zle_highlight=('paste:none')    # Don't highlight text when pasting

# ============================================================================
# HISTORY SETTINGS
# ============================================================================

setopt HIST_SAVE_NO_DUPS        # Don't save duplicate lines
setopt HIST_IGNORE_DUPS         # Don't show duplicate lines in history

HISTSIZE=10000                                             # Lines in memory
SAVEHIST=10000                                             # Lines to save
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"     # History location

# ============================================================================
# VERSION CONTROL (GIT) INTEGRATION
# ============================================================================

autoload -Uz vcs_info                             # Enable vcs_info
precmd() { vcs_info }                             # Load before each prompt

# VCS info styling
zstyle ':vcs_info:*' check-for-changes true       # Check for changes
zstyle ':vcs_info:*' unstagedstr '*'              # Unstaged indicator
zstyle ':vcs_info:*' stagedstr '+'                # Staged indicator
zstyle ':vcs_info:git:*' formats ' (%b%u%c)'      # Format: (branch+*)

# ============================================================================
# PROMPT CONFIGURATION
# ============================================================================

autoload -U colors && colors

# Color definitions
local red="%{$fg[red]%}"
local yellow="%{$fg[yellow]%}"
local green="%{$fg[green]%}"
local blue="%{$fg[blue]%}"
local magenta="%{$fg[magenta]%}"
local reset="%{$reset_color%}"

# Build the prompt: [user@host ~/path (git-branch+*)]
PS1="%B${red}[${yellow}%n${green}@${blue}%M ${magenta}%~\$vcs_info_msg_0_${red}]${reset}%b "

# ============================================================================
# AUTOCOMPLETION
# ============================================================================

autoload -U compinit
zstyle ':completion:*' menu select      # Use menu for completion
zmodload zsh/complist                   # Load completion list module
compinit                                # Initialize completion
_comp_options+=(globdots)               # Include hidden files in completion

zstyle ':completion:*:processes' command 'NOCOLORS=1 ps -U $(whoami) | sed "/ps/d"'
zstyle ':completion:*:processes' insert-ids menu yes select
zstyle ':completion:*:processes-names' command 'NOCOLORS=1 ps xho command | sed "s/://g"'
zstyle ':completion:*:processes' sort false

# ============================================================================
# VI MODE CONFIGURATION
# ============================================================================

bindkey -v                              # Enable vi mode
export KEYTIMEOUT=1                     # Reduce key timeout for mode switching

# Vi keys in tab-complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Cursor shape changes for different vi modes
function zle-keymap-select() {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;          # Block cursor for command mode
        viins|main) echo -ne '\e[5 q';;     # Beam cursor for insert mode
    esac
}

function zle-line-init() {
    zle -K viins                            # Start in insert mode
    echo -ne "\e[5 q"                       # Set beam cursor
}

# Register functions and set initial cursor
zle -N zle-keymap-select
zle -N zle-line-init
echo -ne '\e[5 q'                           # Beam cursor on startup
preexec() { echo -ne '\e[5 q'; }            # Beam cursor for new prompts

# ============================================================================
# CUSTOM FUNCTIONS
# ============================================================================

# LF file manager integration - cd to selected directory
lfcd() {
    local tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"

    if [[ -f "$tmp" ]]; then
        local dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [[ -d "$dir" ]] && [[ "$dir" != "$(pwd)" ]] && cd "$dir"
    fi
}

# ============================================================================
# KEY BINDINGS
# ============================================================================

# File navigation
bindkey -s '^o' 'lfcd\n'                            # ctrl-o: Open lf
bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'        # ctrl-f: fzf directory
bindkey '^[[P' delete-char                          # Fix delete key

# Command editing
autoload edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line                      # ctrl-e: Edit in vim

# ============================================================================
# EXTERNAL CONFIGURATIONS
# ============================================================================

# Load additional configuration files if they exist
[[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc" ]] && \
    source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc"

[[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ]] && \
    source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"

[[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc" ]] && \
    source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc"

# ============================================================================
# ENVIRONMENT VARIABLES
# ============================================================================

if command -v pyenv 1>/dev/null 2>&1; then
   eval "$(pyenv init - zsh)"
fi

# ============================================================================
# PLUGINS (Load last for best compatibility)
# ============================================================================

# Syntax highlighting - must be loaded last
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null

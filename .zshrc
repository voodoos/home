# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f" || \
        print -P "%F{160}▓▒░ The clone has failed.%f"
fi
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit installer's chunk

# opam configuration
test -r /Users/ulysse/.opam/opam-init/init.zsh && . /Users/ulysse/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# ZSH Options
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS

# ZINIT
## Modes
zinit light-mode for \
    zinit-zsh/z-a-bin-gem-node \
    zinit-zsh/z-a-rust

## Base
zinit light willghatch/zsh-saneopt
zinit light mafredri/zsh-async

## Theme
zinit depth=1 for romkatv/powerlevel10k

## Programs
### z
zinit ice wait blockf lucid
zinit light agkozak/zsh-z

### exa
zinit wait"2" lucid as"null" from"gh-r" for \
    mv"exa* -> exa" sbin ogham/exa
alias ls="exa -bh --color=auto"

### diff so fancy
zinit wait"2" lucid as"program" pick"bin/git-dsf" for \
    zdharma/zsh-diff-so-fancy

## Key bindings
### Don't bind these keys until ready
bindkey -r '^[[A'
bindkey -r '^[[B'
function __bind_history_keys() {
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
}

## Completions, suggestions and history
### git
zinit wait lucid for \
    zdharma/zsh-unique-id \
    OMZ::lib/git.zsh \
 atload"unalias grv g" \
    OMZ::plugins/git/git.plugin.zsh

### docker
zinit wait as"completion" lucid for \
    OMZ::plugins/docker/_docker

### Fast-syntax-highlighting & autosuggestions
zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" \
    zdharma/fast-syntax-highlighting \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
 atload'__bind_history_keys' \
    zsh-users/zsh-history-substring-search \
 blockf \
    zsh-users/zsh-completions

# PATH
export PATH=/Library/TeX/texbin/:$PATH

# ALIASES
[[ ! -f ~/.zalias ]] || source ~/.zalias

# P10K
## To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
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

zinit light-mode for \
    zinit-zsh/z-a-bin-gem-node \
    zinit-zsh/z-a-rust

# base
zinit light willghatch/zsh-saneopt
zinit light mafredri/zsh-async

## z
zinit ice wait blockf lucid
zinit light agkozak/zsh-z

## Oh My Zsh
zinit wait lucid for \
    zdharma/zsh-unique-id \
    OMZ::lib/git.zsh \
 atload"unalias grv g" \
    OMZ::plugins/git/git.plugin.zsh

# Theme
zinit light maximbaz/spaceship-prompt
# zinit ice pick"async.zsh" src"pure.zsh"
# zinit light sindresorhus/pure

# Colors
: zinit wait"0c" lucid reset \
 atclone"local P=${${(M)OSTYPE:#*darwin*}:+g}
        \${P}sed -i \
        '/DIR/c\DIR 38;5;63;1' LS_COLORS; \
        \${P}dircolors -b LS_COLORS > c.zsh" \
 atpull'%atclone' pick"c.zsh" nocompile'!' \
 atload'zstyle ":completion:*:default" list-colors "${(s.:.)LS_COLORS}";' for \
    trapd00r/LS_COLORS

zinit wait"0c" lucid \
 atload'zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}";' for \
    zpm-zsh/dircolors-material

# Key bindings
## History search
# Don't bind these keys until ready
bindkey -r '^[[A'
bindkey -r '^[[B'
function __bind_history_keys() {
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
}

# Fast-syntax-highlighting & autosuggestions
zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" \
    zdharma/fast-syntax-highlighting \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
 atload'__bind_history_keys' \
    zsh-users/zsh-history-substring-search \
 blockf \
    zsh-users/zsh-completions

# exa
zinit wait"2" lucid as"null" from"gh-r" for \
    mv"exa* -> exa" sbin ogham/exa
alias ls="exa -bh --color=auto"

zinit wait"2" lucid as"program" pick"bin/git-dsf" for \
    zdharma/zsh-diff-so-fancy

# path
export PATH=/Library/TeX/texbin/:$PATH

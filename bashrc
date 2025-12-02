# Colour  man page output
export PAGER=most

# Vertical format for docker ps
export FORMAT="ID\t{{.ID}}\nNAME\t{{.Names}}\nIMAGE\t{{.Image}}\nPORTS\t{{.Ports}}\nCOMMAND\t{{.Command}}\nCREA
TED\t{{.CreatedAt}}\nSTATUS\t{{.Status}}\n"

# Run my shell scripts
# if [ -f ~/.config/shell_funcs.sh ]; then
   . ~/.config/shell_funcs.sh
# fi

# Add to $PATH
export PATH=$HOME/.local/bin:$PATH

export MANPATH=":/usr/shar/man"

eval "$(zoxide init bash)"

# delete these files on wsl ubuntu
find . -type f -name '*:Zone.Identifier*' -delete
find . -type f -name '*:mshield' -delete

# Set up fzf key bindings and fuzzy completion
# export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -l -g ""'
set FZF_DEFAULT_OPTS "--layout=reverse --border=bold --border=rounded --margin=3% --color=dark"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

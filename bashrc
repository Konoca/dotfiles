#
# /etc/bash.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ $DISPLAY ]] && shopt -s checkwinsize

#PS1='[\u@\h \W]\$ '

# show branch for git repos
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# [user@hostname ~(branch)]
# colorless
#PS1="[\u@\h \W\[\e[91m\]\$(parse_git_branch)\[\e[00m\]]\$ "
# color
PS1="\[\e[00m\][\[\e[35m\]\u@\h \[\e[34m\]\W\[\e[90m\]\$(parse_git_branch)\[\e[00m\]]\$ "

case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'

    ;;
  screen*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
    ;;
esac

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion

# get colors
colors256() {
        local c i j

        printf "Standard 16 colors\n"
        for ((c = 0; c < 17; c++)); do
                printf "|%s%3d%s" "$(tput setaf "$c")" "$c" "$(tput sgr0)"
        done
        printf "|\n\n"

        printf "Colors 16 to 231 for 256 colors\n"
        for ((c = 16, i = j = 0; c < 232; c++, i++)); do
                printf "|"
                ((i > 5 && (i = 0, ++j))) && printf " |"
                ((j > 5 && (j = 0, 1)))   && printf "\b \n|"
                printf "%s%3d%s" "$(tput setaf "$c")" "$c" "$(tput sgr0)"
        done
        printf "|\n\n"

        printf "Greyscale 232 to 255 for 256 colors\n"
        for ((; c < 256; c++)); do
                printf "|%s%3d%s" "$(tput setaf "$c")" "$c" "$(tput sgr0)"
        done
        printf "|\n"
}

# load custom aliases
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export color_prompt=yes


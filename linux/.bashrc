#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
# PS1='[\u@\h \W]\$ '

# linecolour='\[\e[0;37m\]'
# datecolour='\[\e[1;36m\]'
# if [[ $UID == 0 ]]; then
# 	usercolour='\[\e[1;31m\]'
# else
# 	usercolour='\[\e[1;32m\]'
# fi
# hostcolour='\[\e[1;32m\]'
# atcolour='\[\e[1;0m\]'
# dircolour='\[\e[1;34m\]'
# reset='\[\e[0m\]'
# dateformat='%R'
# gitcolour='\e[0:32m\]'
#
# function gitPrompt(){
# 	if [[ -d ".git" ]]; then
# 		echo -e "-[${gitcolour}$(git branch | grep "*" | sed "s/* //")\e[0m]"
# 	fi
# }
#
# PS1="${linecolour}┌─[${usercolour}\u${atcolour}@${hostcolour}\h${linecolour}]-[${datecolour}\$(date \"+${dateformat}\")${linecolour}]-[${dircolour}\${PWD/#\$HOME/~}${linecolour}]\$(gitPrompt)\n${linecolour}└─>${reset} "
#
# Personal
alias vi='nvim '
alias tmux="TERM=screen-256color-bce tmux"

# starship
eval "$(starship init bash)"

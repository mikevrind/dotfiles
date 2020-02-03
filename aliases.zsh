# Shortcuts
alias copyssh="pbcopy < $HOME/.ssh/id_rsa.pub"
alias reloadcli="source $HOME/.zshrc"
alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias weather="curl -4 http://wttr.in"
alias hostfile="sudo vi /private/etc/hosts"
alias aliasfile="vi $DOTFILES/aliases.zsh"
alias list="ls -lisa"
alias line_count="find . -name '*.php' | xargs wc -l"
alias generate_ssh="ssh-keygen -t rsa -b 4096 -o -a 100"
alias dr="defaults read"
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# Directories
alias dotfiles="cd $DOTFILES"
alias code="cd $HOME/code"

# Git aliases
alias gc="git commit -a -S -m"
alias gp="git push"
alias gs="git status"

# Docker
alias dsa="docker ps -qq | xargs docker stop"

php_switch_to() { # php_switch_to 7.2
 brew-php-switcher "$1" -s=valet,apache
}

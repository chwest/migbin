# Declare variables
main_domain=$(uapi DomainInfo list_domains 2>/dev/null | awk '$1 ~ "main_domain:" {print $2}')
newestphpversion=$(ls -1 /usr/local/bin/ea-php7* | tail -n 1 | tr -d @)
RED="\e[31m"
GREEN="\e[32m"
SET="\e[0m"
BLINK="\e[5m"
UNBLINK="\e[25m"
BLUESH="\e[44m"
SETSH="\e[49m"
PS1='\[\e[92m\]\u@${main_domain}\[\e[31m\] \[\e[35m\]\w\[\e[0m\] [$?] \$ '

# ALIASES
alias wp="$newestphpversion ~/bin/migbin/wp"
alias gopub="cd ~/public_html"
alias htoff='mv .htaccess .htaccessOFF'
alias hton='mv .htaccessOFF .htaccess'
alias db='grep DB_ wp-config.php'
alias wpsqlurl="grep -oP siteurl\',\ ?\'[a-zA-Z0-8:/\.~]+\' "
alias dumpdb='wpdbconn -dq'
alias dinfo='$(which python) ~/bin/migbin/dinfo.py | column -t'
alias vprompt='source $HOME/bin/migbin/alt-bashrc'
alias dprompt='source $HOME/bin/migbin/bashrc'

function mkcd() {
    for x in "$@"; do
        mkdir -p "$x"
    done
    cd "${@: -1}"
}

function mig() {
        mkdir -p ~/migration/{files,dbs}
        cd ~/migration/files
}

if [[ ! $(echo $PATH | grep migbin) ]]; then
    PATH=$PATH:~/bin/migbin
fi

cat ~/bin/migbin/migbin
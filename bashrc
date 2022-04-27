main_domain=$(uapi DomainInfo list_domains 2>/dev/null | awk '$1 ~ "main_domain:" {print $2}')
PS1='\[\e[92m\]\u@${main_domain}\[\e[31m\] \[\e[35m\]\w\[\e[0m\] [$?] \$ '
RED="\e[31m"
GREEN="\e[32m"
SET="\e[0m"
BLINK="\e[5m"
UNBLINK="\e[25m"
BLUESH="\e[44m"
SETSH="\e[49m"
newestphpversion=$(ls -1 /usr/local/bin/ea-php7* | tail -n 1 | tr -d @)
alias wp="$newestphpversion ~/bin/migbin/wp"
alias gopub="cd ~/public_html"
alias htoff='mv .htaccess .htaccessOFF'
alias hton='mv .htaccessOFF .htaccess'
alias db='grep DB_ wp-config.php'
alias wpsqlurl="grep -oP siteurl\',\ ?\'[a-zA-Z0-8:/\.~]+\' "
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

# COLORS

RST='\e[0m' # default

BLK='\e[30m'    # black
BBLK='\e[1;30m' # bold black
BGBLK='\e[40m'  # background black

RD='\e[31m'    # red
BRD='\e[1;31m' # bold red
BGRD='\e[41m'  # background red

GR='\e[32m'    # green
BGR='\e[1;32m' # bold green
BGGR='\e[42m'  # background green

YW='\e[33m'    # yellow
BYW='\e[1;33m' # bold yellow
BGYW='\e[43m'  # background yellow

DB='\e[34m'    # dark blue
BDB='\e[1;34m' # bold dark blue
BGDB='\e[44m'  # background dark blue

PR='\e[35m'    # purple
BPR='\e[1;35m' # bold purple
BGPR='\e[m'    # background purple

LB='\e[36m'    # light blue
BLB='\e[1;36m' # bold light blue
BGLB='\e[46m'  # background light blue

WT='\e[37m'    # white
BWT='\e[1;37m' # bold white
BGWT='\e[47m'  # background white

OR='\e[38;5;214m' # orange

# declate sizes for top bar
charct=$(echo $main_domain | wc -c)
mdcol=$(expr $charct + 4)
columns=$(expr "$COLUMNS" - "$mdcol" - 1)
bar=$( echo; echo -en "\r${BLB}┌"; for i in $(seq 1 $columns); do echo -en "─"; done )

# get ipv4 address
IP=$(curl -s ifconfig.me)
# optional prompt command
# PROMPT_COMMAND=''

source ~/bin/migbin/bash_aliases
# print PS1
PS1="$(echo -en "$bar")[ ${DB}${main_domain} ${BLB}]\n[${DB} \u ${WT}${IP} ${BLB}] [ ${BLB}$? ${BLB}] [ ${GR}\j ${BLB}] [ ${WT}\w/ ${BLB}] ${RST}:> "
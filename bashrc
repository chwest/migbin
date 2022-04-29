main_domain=$(uapi DomainInfo list_domains 2>/dev/null | awk '$1 ~ "main_domain:" {print $2}')
#PS1='\[\e[92m\]\u@${main_domain}\[\e[31m\] \[\e[35m\]\w\[\e[0m\] [$?] \$ '
newestphpversion=$(ls -1 /usr/local/bin/ea-php7* | tail -n 1 | tr -d @)

RED="\e[31m"
GREEN="\e[32m"
SET="\e[0m"
BLINK="\e[5m"
UNBLINK="\e[25m"
BLUESH="\e[44m"
SETSH="\e[49m"

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

# get ipv4 address
IP=$(curl -s ifconfig.me)

num_addon=$( $(which python) ~/bin/migbin/dinfo.py | awk '/addon_domain/ {print $0}' | wc -l )
num_subdomains=$( $(which python) ~/bin/migbin/dinfo.py | awk '/sub_domain/ {print $0}' | wc -l )
num_parked=$( $(which python) ~/bin/migbin/dinfo.py | awk '/parked_domain/ {print $0}' | wc -l )

# declate sizes for top bar
charct=$(echo "[ $IP ]─[ main: $main_domain ]─[ addon_domains: $num_addon ]─[ sub_domains: $num_subdomains ]─[ parked_domains: $num_parked ]" | wc -c)
domstring=$(echo -e "[ ${DB}${IP} ${BLB}]─[ main: ${GR}$main_domain ${BLB}]─[ addon_domains: ${WT}$num_addon ${BLB}]─[ sub_domains: ${WT}$num_subdomains ${BLB}]─[ parked_domains: ${WT}$num_parked ${BLB}]")
columns=$(expr "$COLUMNS" - "$charct" - 1)
bar=$( echo -n; echo -en "\r${BLB}┌"; for i in $(seq 1 $columns); do echo -en "─"; done )

# optional prompt command
# PROMPT_COMMAND=''

source ~/bin/migbin/bash_aliases
# print PS1
PS1="$(echo -e "${bar}${domstring}")\n[${DB} \u ${WT}\H ${BLB}] [ ${BLB}$? ${BLB}] [ ${GR}\j ${BLB}] [ ${GR}\w/ ${BLB}] ${RST}:> "
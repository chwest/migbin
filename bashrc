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

function acct_info() {
    echo
    columns=$(tput cols)
    dominfo=$(echo -e "$(domaininfo)")
    dom_table=$(echo -e "${dominfo}" | tail -n +3)
    num_domains=$(echo -e "${dominfo}" | tail -n +3 | wc -l)
    condition=$(echo -e "${dominfo}" | head -n 1)

    if [[ "$condition" == 'TRUE' ]]; then
        current_dom_tmp=$(echo -e "${dominfo}" | sed -n '3'p | awk '{print $1}')
        current_dom=$(echo -e "\e[92m$current_dom_tmp\e[0m")
    elif [[ "$condition" == 'FALSE' ]]; then
        current_dom="No domains assigned to this folder"
    fi

    tput sc
    line1=$(echo -e "${dominfo}" | sed -n "2"p)
    printf "%*s" $columns "DOMAINS: [ ${line1} ]"

    i=3
    for info in $(seq 1 "$num_domains"); do
        line=$(echo -e "${dominfo}" | sed -n "$i"p)
        printf "%*s" $columns "[ ${line} ]"
        ((i++))
    done

    tput rc

    echo -e "USER:$(whoami)\nIPV4:$(curl -s ifconfig.me)\nDOMAINS:$num_domains\nCURRENT:$current_dom" | column -t -s ':'

    for i in $(seq 4 "$num_domains"); do
        echo -e ' '
    done
}

cat ~/bin/migbin/migbin

alias info_on="PROMPT_COMMAND='acct_info'"
alias info_off="PROMPT_COMMAND=''"
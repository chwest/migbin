alias dumpdb='wpdbconn -dq'
alias dinfo='dinfo.py | column -t'
alias addon="dinfo | awk '/addon_domain/ {print $0}'"
alias subdomains="dinfo | awk '/addon_domain/ {print $0}'"
alias parked="dinfo | awk '/addon_domain/ {print $0}'"
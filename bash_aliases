alias dumpdb='wpdbconn -dq'
alias dinfo='$(which python) dinfo.py | column -t'
alias addon="dinfo | awk '/addon_domain/ {print $0}'"
alias sub="dinfo | awk '/addon_domain/ {print $0}'"
alias parked="dinfo | awk '/addon_domain/ {print $0}'"
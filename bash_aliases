alias dumpdb='wpdbconn -dq'
alias dinfo='$(which python) ~/bin/migbin/dinfo.py | column -t'
alias addon="dinfo | awk '/addon_domain/ {print $0}'"
alias sub="dinfo | awk '/sub_domain/ {print $0}'"
alias parked="dinfo | awk '/parked_domain/ {print $0}'"
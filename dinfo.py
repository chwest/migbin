#!/usr/bin/python
import os
import json

uapi_call = os.popen("uapi DomainInfo domains_data --output=jsonpretty format=list api.columns=1 api.columns_0=domain api.columns_1=phpversion api.columns_2=type api.columns_3=documentroot api.sort=1 api.sort_column=type api.sort_method=lexicographic api.sort_reverse=0 | python -mjson.tool")

raw_json = uapi_call.read()
domains_json = json.loads(raw_json)['result']['data']

home_call = os.popen("echo $HOME")
home = home_call.read().rstrip("\n")
pub_h = "{0}/public_html".format(home)

default_php_call = os.popen("uapi LangPHP php_get_system_default_version --output=jsonpretty format=list | python -mjson.tool")
php_json = default_php_call.read()
default_php = json.loads(php_json)['result']['data']['version']

pwd_call = os.popen("pwd")
pwd = pwd_call.read().rstrip("\n")

domains = []
paths = []
types = []
phpver = []

for data in domains_json:    
    if "documentroot" in data:
        paths.append(data['documentroot'])
    else:
        paths.append(pub_h)

    if "phpversion" in data:
        phpver.append(data['phpversion'])
    else:
        phpver.append(default_php)
    
    domains.append(data['domain'])
    types.append(data['type'])

for domain in domains:
    dindex = domains.index(domain)
    if paths[dindex] == pwd:
        domain_string = "{0} {1}/ {2} {3} (current)".format(domains[dindex], paths[dindex], types[dindex], phpver[dindex])
    else:
        domain_string = "{0} {1}/ {2} {3}".format(domains[dindex], paths[dindex], types[dindex], phpver[dindex])
    print(domain_string)

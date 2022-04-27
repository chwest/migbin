#!/bin/python
import os
import json

uapi_call = os.popen("uapi DomainInfo domains_data --output=jsonpretty format=list api.columns=1 api.columns_0=domain api.columns_1=phpversion api.columns_2=type api.columns_3=documentroot api.sort=1 api.sort_column=type api.sort_method=lexicographic api.sort_reverse=0 | python -mjson.tool")

raw_json = uapi_call.read()
domains_json = json.loads(raw_json)['result']['data']

pwd_call = os.popen("pwd")
pwd = pwd_call.read().rstrip("\n")

domains = []
paths = []
types = []
phpver = []

for data in domains_json:
    if data['type'] == 'main_domain':
        general_php = data['phpversion']
        main_path = data['documentroot']

for data in domains_json:    
    domains.append(data['domain'])
    types.append(data['type'])

    if "documentroot" in data:
        paths.append(data['documentroot'])
    else:
        paths.append(main_path)

    if "phpversion" in data:
        phpver.append(data['phpversion'])
    else:
        phpver.append(general_php)


for domain in domains:
    dindex = domains.index(domain)
    if paths[dindex] == pwd:
        domain_string = "{} {} {} {} (current)".format(domains[dindex], paths[dindex], types[dindex], phpver[dindex])
    else:
        domain_string = "{} {} {} {}".format(domains[dindex], paths[dindex], types[dindex], phpver[dindex])
    print(domain_string)

#!/usr/bin/env python3

import json
import sys
import io
import urllib.request

usernames = ['KongBoje', 'LasseHansenCPH', 'MartinH5', 'Huldumadurin']
keycounts = [] 
keys = []

#Ensuring UNIX newlines for consistent behavior.
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, newline='\n' )

for username in usernames:
    count = 0
    contents = urllib.request.urlopen("https://api.github.com/users/" + username +  "/keys").read()
    try:
        data = json.loads(contents)
        for i in data:
            keys.append(i['key'] + " " + username + "@" + str(i['id']))
            sys.stderr.write("Key found for " + username + ":\n")
            count += 1
    except:
        sys.stderr.write("No keys found for " + username)
    keycounts.append([username, count])
    
for key in keys:
    print(key)
print("\n")
    
sys.stderr.write("Found:")
for pair in keycounts:
    sys.stderr.write("\t" + str(pair))

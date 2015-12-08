#!/usr/bin/env python3.5
'''
This script scrapes studio.code.org for the current standards mappings of their lesson plans.
'''

# http://stackoverflow.com/questions/20759981/python-trying-to-post-form-using-requests

from bs4 import BeautifulSoup as bs
# from getpass import getpass as gp
from hashlib import md5
import requests
import sys
import urllib

def parseLesson(soup):
    '''
    This function takes a BeautifulSoup object for a Code.org lesson page and
    gets the lesson name as well as any standards hits.
    '''

    # get name
    name = soup.find_all("h1")[0].get_text()

    # get hits

    # PARCC

    # ISTE

    # CSTA

    # NGSS

    # CC Math practices

    # CC Math

    # CC LA

username = 'andyras+edumap@gmail.com'
password = 'edumapissupergreat'
# password = gp('password: ')
signInURL = 'https://studio.code.org/users/sign_in'

# do this nonsense for the hashed username
m = md5()
m.update(username.encode('utf-8'))
hashedUsername = m.hexdigest()

headers = {'User-Agent': 'Mozilla/5.0'}
payload = {'user[login]': username,
           'user[hashed_email]': hashedUsername, # probably don't need this
           'user[password]': password,
           'commit': 'Sign in'}

# get authentication token and such
session = requests.Session()
response = session.get(signInURL)

soup = bs(response.text, 'html.parser')

auth_tokens = []
for inp in soup.find_all('input'):
    if inp['name'] == 'authenticity_token':
        auth_tokens.append(inp['value'])

try:
    # add first auth token to payload
    payload['authenticity_token'] = auth_tokens[0]
except:
    print("ERROR: No authenticity tokens found.")
    sys.exit()

# sign in to code.org
r = session.post(signInURL, headers=headers, data=payload)

print(r.status_code)
# print(r.text)

# for each course, get lessons
    # for each lesson
        # get lesson description
        # get codes for each standard

r = session.get('https://studio.code.org/s/course4')
print(r.status_code)

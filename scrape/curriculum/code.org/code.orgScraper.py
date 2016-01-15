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

def codeSession():
    '''
    returns a session object that has signed into code.org
    '''

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

    return session

def getISTE(soup):
    '''
    Print the ISTE standard codes from a code.org lesson
    '''

    ISTEtag = soup.find("h3", text="ISTE Standards (formerly NETS)")
    ISTEul = ISTEtag.find_next("ul")

def parseLesson(lesson, session):
    '''
    This function takes a BeautifulSoup object for a Code.org lesson page and
    gets the lesson name as well as any standards hits.
    '''

    r = session.get("https:" + lesson.a['href'])

    soup = bs(r.text, "html5lib")

    # get name
    name = soup.find_all("h1")[0].get_text()
    print(name)

    # get hits

    # PARCC

    # ISTE
    getISTE(soup)

    # CSTA

    # NGSS

    # CC Math practices

    # CC Math

    # CC LA

def parseCourse(courseName, session):
    '''
    Parses a code.org course page.
    '''

    # make course soup, mmm
    r = session.get('https://studio.code.org/s/' + courseName)
    print("%s status for Code.org %s retrieval" % (r.status_code, courseName))
    course = bs(r.text, "html5lib")

    lessons = course.findAll("div", {"class", "stage-lesson-plan-link"})

    # find divs with class="stage-lesson-plan-link"
    for lesson in lessons:
        parseLesson(lesson, session)

# main.exe

session = codeSession() # create session object

# list comprehension
courses = ['course' + str(x) for x in range(1,5)] + ['algebra']
courses = ['course1']
for course in courses:
    parseCourse(course, session)
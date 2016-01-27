#!/usr/bin/env python3.5
'''
This script scrapes studio.code.org for the current standards mappings of their lesson plans.
'''

# http://stackoverflow.com/questions/20759981/python-trying-to-post-form-using-requests

from bs4 import BeautifulSoup as bs
# from getpass import getpass as gp
from unicodecsv import writer
from hashlib import md5
import re
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

def codeGrab(li):
    '''
    grabs the code from a bs li on a code.org lesson plan page.

    Assumption: code is first item in split() string, may have trailing period or colon
    '''

    return li.get_text().split()[0].rstrip(".:")

def parseLesson(lesson, session):
    '''
    This function takes a BeautifulSoup object for a Code.org lesson page and
    gets the lesson name as well as any standards hits.
    '''

    lessonUrl = "https:" + lesson.a['href']
    courseNo = lessonUrl.split("/")[4][-1]
    lessonNo = lessonUrl.split("/")[5]
    lessonCode = "Code.org" + courseNo + "." + lessonNo

    # open page
    r = session.get(lessonUrl)
    soup = bs(r.text, "html5lib")

    # get name
    name = soup.find_all("h1")[0].get_text()
    print(lessonCode, name)

    # get standards hits
    maps = []

    headers = soup.find_all("h3")
    for header in headers:
        found_header = False
        headerText = header.get_text()

        if "ISTE" in headerText:
            found_header = True
            standardName = "ISTE"
        elif "CSTA" in headerText:
            found_header = True
            standardName = "CSTA"
        elif "Common Core Mathematical" in headerText:
            found_header = True
            standardName = "CCMP"
        elif "Common Core Math Standards" in headerText:
            found_header = True
            standardName = "CC Math"
        elif "Language Arts" in headerText:
            found_header = True
            standardName = "CC LA"

        if found_header == True:
            ul = header.find_next("ul")
            for li in ul.find_all("li"):
                maps.append([lessonUrl, lessonCode, name, standardName, codeGrab(li)])

    return maps

def parseCourse(courseName, session, csvOut):
    '''
    Parses a code.org course page.
    '''

    # make course soup, mmm
    r = session.get('https://studio.code.org/s/' + courseName)
    print("%s status for Code.org %s retrieval" % (r.status_code, courseName))
    course = bs(r.text, "html5lib")

    # find divs with class="stage-lesson-plan-link"
    lessons = course.findAll("div", {"class", "stage-lesson-plan-link"})

    for lesson in lessons:
        maps = parseLesson(lesson, session)
        csvOut.writerows(maps)

# main.exe

session = codeSession() # create session object

# list comprehension
courses = ['course' + str(x) for x in range(1,4)] + ['algebra']
# courses = ['course1']

with open("code.org_maps.csv", "w+") as f:
    csvOut = writer(f)

    for course in courses:
        parseCourse(course, session, csvOut)

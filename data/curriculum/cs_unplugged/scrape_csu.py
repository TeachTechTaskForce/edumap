#!/usr/bin/env python2.7
'''
This script scrapes curriculum info about CS Unplugged
'''

debug = True

from bs4 import BeautifulSoup as bs
from unicodecsv import writer
import os
import urllib
import urllib2

import pdfscrape

def download_pdf(url):
    if debug:
        print("downloading %s" % url)
    fileName = os.path.split(url)[-1]
    print(fileName)

    response = urllib2.urlopen(url)
    with open(fileName, 'w') as f:
        f.write(response.read())

    if debug:
        print("downloaded %s" % fileName)

def cleanLink(url):
    '''
    Clean up wordpress links to match tld for CS Unplugged
    '''

    if url.startswith("/wp-content"):
        url = "http://csunplugged.org" + url

    return url


url = 'http://csunplugged.org/activities/'
opener = urllib.FancyURLopener()

### get activity links
soup = bs(opener.open(url), 'html.parser')
links = soup.find("div", class_='view-header').find_all("a")
units = soup.find_all("h5")

activities = []

with open('cs_unplugged.csv', 'w') as o:
    csvOut = writer(o)
    csvOut.writerow(["Topic", "Activity", "Ages", "Materials"])

    for unit in units:
        # get each list of links
        links = unit.findNext("ul").find_all("a")

        # write unit to csv
        csvOut.writerow([unit.get_text(), "", "", ""])

        # process links
        for link in links:
            if link.has_attr('href'):
                myurl = cleanLink(link['href'])
            else:
                print("ERROR: link %s has no link" % link.string)

            if myurl in activities:
                print("WARNING: activity at %s already processed." % myurl)
                print("Skipping this page")
                continue
            else:
                activities.append(myurl)

            soup = bs(opener.open(myurl), 'html.parser')

            # find title of activity
            titleHeader = soup.find("h1")
            if titleHeader == None:
                print("WARNING: no title for page at %s" % myurl)
                print("Skipping this page")
                continue
            else:
                title = titleHeader.findNext("a").get_text()
                print(title)

            # find subtitle
            subtitleHeader = titleHeader.findNext("h3")
            if subtitleHeader == None:
                print("WARNING: no title for page at %s" % myurl)
                print("Skipping this page")
                continue
            else:
                subtitle = subtitleHeader.get_text()
                print(subtitle)

            # find link to .pdf: first get 'Downloads' header, then get first link
            dl = soup.find("span", id="Downloads")
            if dl == None:
                print("WARNING: no Downloads for page %s" % myurl)
                print("Skipping this page")
                continue
            else:
                pdflink = cleanLink(dl.findNext("a")['href'])
                if debug:
                    print(pdflink)

                pdfName = os.path.split(pdflink)[-1]

                # check if file is already downloaded
                if not os.path.isfile(pdfName):
                    print("Downloading %s..." % pdfName)
                    download_pdf(pdflink)

                print("Processing %s..." % pdfName)
                age, materials = pdfscrape.csu_pdfscrape(pdfName)

            # write out this entry to csv
            csvOut.writerow([title, subtitle, str(age) + "+", "\r".join(materials)])
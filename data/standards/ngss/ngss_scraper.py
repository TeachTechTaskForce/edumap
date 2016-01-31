# -*- coding: utf-8 -*-
import csv, re, codecs, cStringIO
from ucsv import UnicodeWriter as unicsv

topic_list = []
detail_dict = {}

break_toc = '''
November 2013©2013 Achieve, Inc. All rights reserved.2 of 103
'''

sec_break = "The performance expectations above were developed"

curr_code = re.compile('[K12345MH][\-S]\S{3,6}')
code_title = re.compile('\s[A-Z].{3,50}[^\.]')
curr_sub = re.compile(('[K12345MH][\-S]\S{3,10}'))

with codecs.open("ngss_test.txt", "r", "utf-8") as f:
    for line in f:
        if line == break_toc:
            break
        elif not curr_code.match(line) == None:
            item = []
            item.append(curr_code.findall(line)[0])
            item.append((code_title.findall(line)[0]).strip())
            topic_list.append(item)

with open('ngss_topics.csv', 'wb') as csvfile:
    rwriter = unicsv(csvfile)
    for topic in topic_list:
        rwriter.writerow(topic)

with codecs.open("ngss_dci.txt", "r", "utf-8") as f2:
    it = 0
    subcode = False
    for line in f2:
        if line.startswith(sec_break):
            subcode = False
            it += 1
            if it > (len(topic_list) - 1):
                break
        elif line.startswith(topic_list[it][0]):
            subcode = curr_sub.findall(line)[0]
            subcode = subcode[:-1].encode("ascii", "ignore")
            content_start = line[len(subcode) + 1:]
            detail_dict[subcode] = content_start.replace("\n", "")
        elif subcode != False:
            added_line = " " + line.replace("\n", "")
            detail_dict[subcode] += added_line

with open('ngss_descriptions.csv', 'wb') as csvfile:
    rwriter = unicsv(csvfile)
    for key, val in detail_dict.items():
        rwriter.writerow([key, val])

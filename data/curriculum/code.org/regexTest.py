#!/usr/bin/env python3.5

import re

lessonRE = re.compile(r'.*dashboard\.progress\.renderCourseProgress\((.*)\).*')

with open("regexTest.html", "r") as i:
    lines = "".join([l.strip() for l in i.readlines()])

guy = re.sub(lessonRE, r'\1', lines)

print(guy)
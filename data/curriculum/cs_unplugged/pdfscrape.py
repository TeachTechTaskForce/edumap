#!/usr/bin/env python2.7

# pdfminer and pyPdf modules did not work, textract did

import textract

def csu_pdfscrape(pdf):
    text = textract.process(pdf).split('\n')
    age = 0
    materials = []
    for ii, line in enumerate(text):
        if "Ages" == line:
            age = int(text[ii+1].split()[1]) # get minimum age
        if line.strip() == "Materials":
            # get 20 lines or until blank line
            jj = 1
            thisLine = text[ii+jj].strip()
            while jj < 20 and thisLine != "":
                if thisLine.startswith("9 "): # get rid of incorrectly read bullets
                    thisLine = "-" + thisLine[1:]
                materials.append(thisLine)
                jj += 1
                thisLine = text[ii+jj].strip()

    return age,materials

# pdf = 'unplugged-01-binary_numbers.pdf'

# csu_pdfscrape(pdf)
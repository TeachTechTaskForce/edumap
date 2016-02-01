import os;
from os import listdir;
from os.path import isfile, join;

#Get Files to Scrape and Clean
folderPath = 'unplugged'
filesToScrape = [f.replace('.pdf', '') for f in listdir(folderPath) if isfile(join(folderPath, f))]

#Do the Scraping and Cleaning
for fileName in filesToScrape:
	filePath = folderPath + "/" + fileName
	print '{0}\r'.format(filePath + ": open file"),
	#Scrape the Files
	os.system('pdf2txt.py -o ' + filePath + '.txt ' + filePath + '.pdf')
	print '{0}\r'.format(filePath + ": scraping complete"),
	#Clean the Materials
	f = open(filePath + '.txt', 'r')
	printing = False;
	materialsList = []
	lineCounter = 0
	for line in f:
		lineCounter += 1
		print '{0}\r'.format(filePath + ": reading line ", lineCounter),
		if "Photocopiable" in line or "Creative Commons" in line:
			printing = False
		if printing:
			material = line.replace('(cid:57)', '').strip();
			if len(material) > 0:
				materialsList.append(material)
		if "Materials" in line:
			printing = True
	#Write the Materials
	f = open(filePath + '.txt', 'w')
	for material in materialsList:
		f.write(material + "\n")
	print '{0}\r'.format(filePath + ": output complete"),
	print
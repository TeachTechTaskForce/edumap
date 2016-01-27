import os;
from os import listdir;
from os.path import isfile, join;


BASE_PATH = 'pdf/'

folders = [(BASE_PATH + folderPath + '/') for folderPath in listdir(BASE_PATH)];

filesToScrape = [(folderPath + filename) for filename in listdir(folderPath) for folderPath in folders]


for filename in filesToScrape:
	print filename

#for(filename in files):
	#os.system('pdf2txt.py -o output/' + filename + '.txt ' + filename + '.pdf')
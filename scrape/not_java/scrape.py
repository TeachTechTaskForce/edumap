import os;

filePath = 'unplugged/01binarynumbers'
os.system('pdf2txt.py -o ' + filePath + '.txt ' + filePath + '.pdf')

f = open(filePath + '.txt', 'r')
printing = False;
materialsList = []
for line in f:
	if "Photocopiable" in line:
		printing = False
	if printing:
		material = line.replace('(cid:57)', '').strip();
		if len(material) > 0:
			materialsList.append(material)
	if "Materials" in line:
		printing = True

f = open(filePath + '.txt', 'w')

for material in materialsList:
	f.write(material + "\n")
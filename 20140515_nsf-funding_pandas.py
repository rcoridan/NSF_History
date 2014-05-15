# Following tutorial on XML from https://docs.python.org/2/library/xml.etree.elementtree.html
#	recommended by http://www.rdegges.com/quickly-extract-xml-data-with-python/

from xml.etree import ElementTree as ET
import os, glob
import pandas as pd
import unicodedata

ziplist=glob.glob('*.zip')

for zipfile in ziplist:
	yeartext=zipfile[0:4]
	if not os.path.isfile(yeartext+'nsf_awards.csv'):
		os.system('unzip '+zipfile)

		df=pd.DataFrame()
		xmlfilelist=glob.glob('*.xml')
		nFiles=len(xmlfilelist)
		print ('year:'+yeartext+'	nFiles='+str(nFiles))
		for xmlfile in xmlfilelist:
			awardi={'year':yeartext}
			tree=ET.parse(xmlfile)
			root=tree.getroot()
			for child in root.iter():
				#need to remove weird Unicode chars that 'to_csv' doesn't like
				x=child.text
				#don't do anything if the string is empty
				#probably a branch in tree
				if isinstance(x,unicode):
					x=unicodedata.normalize('NFKD',x).encode('ascii','ignore')
				#need to check if the key is unique, other values get overwritten
				y=child.tag
				if y in awardi:
					z=1
					while y+str(z) in awardi:
						z+=1
					y=y+str(z)
				awardi[y]=[x]
			adf=pd.DataFrame(awardi)
			df=pd.concat([df,adf],ignore_index=True)
			os.remove(xmlfile)
			if len(df.index)%round(1.0+nFiles/4.0) == 0:
				print len(df.index)
				df.to_csv(yeartext+'nsf_awards.csv',index=False)

		len(df.index)
		df.to_csv(yeartext+'nsf_awards.csv',index=False)

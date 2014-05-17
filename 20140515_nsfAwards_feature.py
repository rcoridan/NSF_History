import pandas as pd
import os, glob

filelist=glob.glob('[1-2]*nsf_awards.csv')
coll=pd.DataFrame()

keepList=['AbstractNarration','AwardAmount','AwardEffectiveDate','AwardExpirationDate','AwardID','AwardTitle','CityName','CountryName','LongName','LongName1','Name','StateCode','StateName','Text','Text1','year']
for filename in filelist:
	print(filename)
	df=pd.read_csv(filename,low_memory=False)

	#append missing columns 
	#	need to copy list rather than assign A=B (by reference)
	missingList=list(keepList)
	thereList=list([])
	#check to see which keys in df are missing from the ones to be collected
	for ki in df.keys():
		if ki in keepList:
			missingList.remove(ki)
			thereList.append(ki)
	#add the missing columns with no value
	for ki in missingList:
		df[ki]='NA'
	print(keepList)
	df=df[keepList]
	df.to_csv('clean_'+filename)
	coll=pd.concat([coll,df],ignore_index=True)
coll.to_csv('clean_nsf_awards_all.csv')
print coll.keys()
print len(coll)

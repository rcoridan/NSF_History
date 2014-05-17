import pandas as pd
import os, glob

filelist=glob.glob('201*nsf_awards.csv')
coll=pd.DataFrame()
for filename in filelist:
	df=pd.read_csv(filename)

	keepList=['AbstractNarration','AwardAmount','AwardEffectiveDate','AwardExpirationDate','AwardID','AwardTitle','CityName','CountryName','LongName','LongName1','Name','StateCode','StateName','Text','Text1','year']

	df=df[keepList]
	df.to_csv('clean_'+filename)
	coll=pd.concat([coll,df],ignore_index=True)
coll.to_csv('clean_nsf_awards_all.csv')
print len(coll)

import pandas as pd
filename ='2012nsf_awards.csv'
df=pd.read_csv(filename)

keepList=['AbstractNarration','AwardAmount','AwardEffectiveDate','AwardExpirationDate','AwardID','AwardTitle','CityName','CountryName','LongName','LongName1','Name','StateCode','StateName','Text','Text1','year']

df=df[keepList]
df.to_csv('2012_clean_nsf_awards.csv')


require(devtools)
require(rCharts)
#install_github('slidify','ramnathv',ref='dev')
#install_github('slidifyLibraries','ramnathv',ref='dev')
options(RCHART_TEMPLATE = 'Rickshaw.html')


#get data
df<-read.csv('clean_nsf_awards_all.csv',stringsAsFactors=FALSE)
directorates<-unique(unlist(df$LongName))
years<-unique(unlist(df$year))

cc=data.frame()

for (yr in years){
  for (dd in directorates){
    num<-length(df[  df$LongName == dd & df$year == yr ,'year'])
    totExp<-sum(df[  df$LongName == dd & df$year == yr,'AwardAmount'])
    
    #fix some strings
    dnm<-dd
    if (dd == ""){
      dnm<-'Not Available'
    }
    if (dd == "OFFICE OF THE DIRECTOR"){
      # "OFFICE OF THE DIRECTOR"
      dnm<-'Office of the Director'
    }
    
    #save points to collector dataframe cc
    #yrdate<-as.Date(toString(yr),format='%Y')
    yrdate<-ISOdate(yr,1,1,12,0,0)
    exi<-data.frame(Year=yrdate,Directorate=dnm,TotGrants=num,TotExp=totExp,stringsAsFactors=FALSE)
    cc<-rbind(cc,exi)
  }
}

saveForWeb=TRUE

r5 <- Rickshaw$new()
r5$layer ( 
  TotGrants ~ Year, data = cc,groups = "Directorate",
  height = 600,width = 800
)
#turn off features not used in the example
r5$set(
  hoverDetail = TRUE, shelving = FALSE, legend = TRUE,
  slider = FALSE, highlight = TRUE, scheme='colorwheel'
)
r5
r5$save('20140516_nsf_number.html')
filetext<-readLines('20140516_nsf_number.html')
if (saveForWeb) {
  dirStrg<-'/Library/Frameworks/R.framework/Versions/3.1/Resources/library/rCharts/libraries/'
  filetext[4]=sub(dirStrg,'',filetext[4])
  filetext[5]=sub(dirStrg,'',filetext[5])
  filetext[7]=sub(dirStrg,'',filetext[7])
  filetext[8]=sub(dirStrg,'',filetext[8])
  filetext[9]=sub(dirStrg,'',filetext[9])
  filetext[10]=sub(dirStrg,'',filetext[10])
}
filetext[31]=sub('-160px;','440px; font-size:  10px;',filetext[31])
writeLines(filetext, con = "20140516_nsf_number.html", sep = "\n", useBytes = FALSE)

r6 <- Rickshaw$new()
r6$layer ( 
  TotExp ~ Year, data = cc,groups = "Directorate",
  height = 600,width = 800
)
#turn off features not used in the example
r6$set(
  hoverDetail = TRUE, shelving = FALSE, legend = TRUE,
  slider = FALSE, highlight = TRUE, scheme='colorwheel'
)
r6
r6$save('20140516_nsf_expenditures.html')
filetext<-readLines('20140516_nsf_expenditures.html')
if (saveForWeb) {
  dirStrg<-'/Library/Frameworks/R.framework/Versions/3.1/Resources/library/rCharts/libraries/'
  filetext[4]=sub(dirStrg,'',filetext[4])
  filetext[5]=sub(dirStrg,'',filetext[5])
  filetext[7]=sub(dirStrg,'',filetext[7])
  filetext[8]=sub(dirStrg,'',filetext[8])
  filetext[9]=sub(dirStrg,'',filetext[9])
  filetext[10]=sub(dirStrg,'',filetext[10])
}
filetext[31]=sub('-160px;','440px; font-size:  10px;',filetext[31])
writeLines(filetext, con = "20140516_nsf_expenditures.html", sep = "\n", useBytes = FALSE)

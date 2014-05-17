
require(devtools)
require(rCharts)
#install_github('slidify','ramnathv',ref='dev')
#install_github('slidifyLibraries','ramnathv',ref='dev')
options(RCHART_TEMPLATE = 'Rickshaw.html')


#get data
df<-read.csv('clean_nsf_awards_all.csv')
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
    if (dd == directorates[5]){
      # "OFFICE OF THE DIRECTOR"
      dnm<-'Office of the Director'
    }
    
    #save points to collector dataframe cc
    #yrdate<-as.Date(toString(yr),format='%Y')
    yrdate<-ISOdate(yr,1,1,12,0,0)
    exi<-data.frame(Year=yrdate,Directorate=dnm,TotGrants=num,TotExp=totExp,stringsAsFactors=FALSE)
    cc=rbind(cc,exi)
  }
}


r5 <- Rickshaw$new()
r5$layer ( 
  TotGrants ~ Year, data = cc,groups = "Directorate",
  height = 600,width = 800
)
#turn off features not used in the example
r5$set(
  hoverDetail = TRUE, shelving = FALSE, legend = TRUE,
  slider = FALSE, highlight = FALSE, scheme='colorwheel'
)
r5


r6 <- Rickshaw$new()
r6$layer ( 
  TotExp ~ Year, data = cc,groups = "Directorate",
  height = 400,width = 600
)
#turn off features not used in the example
r6$set(
  hoverDetail = TRUE, shelving = FALSE, legend = TRUE,
  slider = FALSE, highlight = FALSE, scheme='colorwheel'
)
r6

#setup all subdirectories 
dir.create("rawdata")
dir.create("code")
dir.create("resources")
dir.create("report")
dir.create("images")
dir.create("data")


#Getting twitter data 
if (file.exists("rawdata/GOP_REL_ONLY.csv")) {
  file.rename(from = "rawdata/GOP_REL_ONLY.csv", 
              to = "rawdata/twitter_debate.csv")
} else if (!file.exists("rawdata/twitter_debate.csv")) {
	download.file(
	  paste("http://cdn2.hubspot.net/hubfs/346378/DFE_CSVs/",
	  "GOP_REL_ONLY.csv?t=1447202498004", sep = ""), 
              destfile = "rawdata/GOP_REL_ONLY.csv")
  file.rename(from = "rawdata/GOP_REL_ONLY.csv", 
              to = "rawdata/twitter_debate.csv")
} else {
  print("File already exists") 
}


#Getting Polling data for the candidates 
if (file.exists("rawdata/2016-national-gop-primary.csv.csv")) {
  file.rename(from = "rawdata/2016-national-gop-primary.csv", 
              to = "rawdata/polling.csv")
} else if(!file.exists("rawdata/polling.csv")){
	download.file(
	paste("http://elections.huffingtonpost.com/pollster/",
	"2016-national-gop-primary.csv", sep = ""),
	              destfile = "rawdata/2016-national-gop-primary.csv")
  file.rename(from = "rawdata/2016-national-gop-primary.csv",
              to = "rawdata/polling.csv")
} else {
	    print("File already exists")  
}

#Getting Independent expenditure data for the candidates 
if (file.exists("rawdata/independent-expenditure.csv")) {
  file.rename(from = "rawdata/independent-expenditure.csv", 
              to = "rawdata/ind_expenditure.csv")
} else if (!file.exists("rawdata/ind_expenditure.csv")){
  download.file(
    "http://www.fec.gov/data/IndependentExpenditure.do?format=csv", 
    destfile = "rawdata/independent-expenditure.csv")
  file.rename(from = "rawdata/independent-expenditure.csv", 
              to = "rawdata/ind_expenditure.csv")
} else {
  print("File already exists")  
}


#expenditure data 
#from http://www.fec.gov/disclosurep/PDownload.do
#backup link http://www.fec.gov/data/DataCatalog.do

if (file.exists("rawdata/P00000001D-ALL.csv")) {
  file.rename("rawdata/P00000001D-ALL.csv", "rawdata/expenditure_data.csv")
} else if(!file.exists("rawdata/expenditure_data.csv")){
  download.file(paste("ftp://ftp.fec.gov/FEC/Presidential_Map/",
                "2016/P00000001/P00000001D-ALL.zip", sep = ""),
                "rawdata/P00000001D-ALL.zip")
  unzip("rawdata/P00000001D-ALL.zip", exdir = "rawdata/")
  file.rename("rawdata/P00000001D-ALL.csv", "rawdata/expenditure_data.csv")
  file.remove("rawdata/P00000001D-ALL.zip")
} else {
	    print("File already exists")  
}


#Getting contributor data 
if (file.exists("rawdata/P00000001-ALL.csv")) {
  file.rename("rawdata/P00000001-ALL.csv", "rawdata/contributor_data.csv")
} else if(!file.exists("rawdata/contributor_data.csv")){
  download.file(paste("ftp://ftp.fec.gov/FEC/Presidential_Map/",
                "2016/P00000001/P00000001-ALL.zip", sep = ""),
                "rawdata/P00000001-ALL.zip")
  unzip("rawdata/P00000001-ALL.zip", exdir = "rawdata/")
  file.rename("rawdata/P00000001-ALL.csv", "rawdata/contributor_data.csv")
  file.remove("rawdata/P00000001-ALL.zip")
} else {
  print("File already exists")  
}






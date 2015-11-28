#Script to get data from http://www.crowdflower.com/data-for-everyone

if(!file.exists("/Users/bryanalcorn/Dropbox/Group Proj Stats133/rawdata/GOP_REL_ONLY.csv")) {
download.file("http://cdn2.hubspot.net/hubfs/346378/DFE_CSVs/GOP_REL_ONLY.csv?t=1447202498004", 
              destfile = "/Users/bryanalcorn/Dropbox/Group Proj Stats133/rawdata/GOP_REL_ONLY.csv")
} else {
    print("File already exists")  
}


if()

#polling data!!, use this to verify your predictions because it contains dates 
#http://elections.huffingtonpost.com/pollster/2016-national-gop-primary.csv


#Download from a zip file as well, how to http://stackoverflow.com/questions/3053833/using-r-to-download-zipped-data-file-extract-and-import-data
#expenditure data 
#http://www.fec.gov/disclosurep/PDownload.do
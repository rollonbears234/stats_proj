You need to make the files pathes relative, the current way you have it will not work
code <= 80 characters!! 

#Script to get data from http://www.crowdflower.com/data-for-everyone

if(!file.exists("/Users/bryanalcorn/Dropbox/Group Proj Stats133/rawdata/GOP_REL_ONLY.csv")) {
	download.file("http://cdn2.hubspot.net/hubfs/346378/DFE_CSVs/GOP_REL_ONLY.csv?t=1447202498004", 
              destfile = "/Users/bryanalcorn/Dropbox/Group Proj Stats133/rawdata/GOP_REL_ONLY.csv")
} else {
    print("File already exists")  
}


if(!file.exists("/Users/bryanalcorn/Dropbox/Group Proj Stats133/rawdata/2016-national-gop-primary.csv")){
	download.file("http://elections.huffingtonpost.com/pollster/2016-national-gop-primary.csv", 
	              destfile = "/Users/bryanalcorn/Dropbox/Group Proj Stats133/rawdata/2016-national-gop-primary.csv")
} else {
	    print("File already exists")  
}


#Download from a zip file as well, how to http://stackoverflow.com/questions/3053833/using-r-to-download-zipped-data-file-extract-and-import-data
#expenditure data 
#http://www.fec.gov/disclosurep/PDownload.do


if(!file.exists("/Users/bryanalcorn/Dropbox/Group Proj Stats133/rawdata/P00000001D-ALL.csv")){
	download.file("http://elections.huffingtonpost.com/pollster/2016-national-gop-primary.csv", 
	              destfile = "/Users/bryanalcorn/Dropbox/Group Proj Stats133/rawdata/P00000001D-ALL.csv")
} else {
	    print("File already exists")  
}

if(!file.exists("/Users/bryanalcorn/Dropbox/Group Proj Stats133/rawdata/P00000001-ALL.csv")){
	download.file(
	"http://elections.huffingtonpost.com/pollster/2016-national-gop-primary.csv", 
	destfile = "/Users/bryanalcorn/Dropbox/Group Proj Stats133/rawdata/P00000001-ALL.csv")
} else {
	    print("File already exists")  
}



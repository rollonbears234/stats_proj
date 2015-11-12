#Script to get data from http://www.crowdflower.com/data-for-everyone

if(!file.exists("/Users/bryanalcorn/Dropbox/Group Proj Stats133/rawdata/GOP_REL_ONLY.csv")) {
download.file("http://cdn2.hubspot.net/hubfs/346378/DFE_CSVs/GOP_REL_ONLY.csv?t=1447202498004", 
              destfile = "/Users/bryanalcorn/Dropbox/Group Proj Stats133/rawdata/GOP_REL_ONLY.csv")
} else {
    print("File already exists")  
}


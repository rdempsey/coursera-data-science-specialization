# Import required libraries
library(xlsx)
library(XML)
library(data.table)

# Set the working directory
setwd("/Users/robertdempsey/Dev/coursera-data-science-specialization/getting-and-cleaning-data/Week 1")

# Ensure the data directory exists. If not, create it.
if(!file.exists("data")) {
  dir.create("data")
}

## QUESTION 1 ##

destFile <- "./data/getdata-data-ss06hid.csv"

if(!file.exists(destFile)) {
  # Set the download URL of the file
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
  
  # Download the file and tell it where to go
  download.file(fileUrl, destfile=destFile, method="curl")
  
  # Get the date the file was downloaded
  dateDownloaded <- date()
  dateDownloaded
}

# Read the data into a variable
acsdata <- read.table(destFile, sep = ",", header = TRUE)

# Get the count of houses worth 1,000,000 or more
# Worth: VAL(24)
acsDT <- data.table(acsdata)
acsDT[acsDT$VAL=="24"]


## QUESTION 3 ##

destFile <- "./data/getdata-data-DATA.gov_NGAP.xlsx"

if(!file.exists(destFile)) {
  # Set the download URL of the file
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
  
  # Download the file and tell it where to go
  download.file(fileUrl, destfile=destFile, method="curl")
  
  # Get the date the file was downloaded
  dateDownloaded <- date()
  dateDownloaded
}

# Read only part of the file to create a subset
colIndex <- 7:15
rowIndex <- 18:23
dat <- read.xlsx(destFile, sheetIndex = 1, header = TRUE, colIndex = colIndex, rowIndex = rowIndex)

sum(dat$Zip*dat$Ext,na.rm=T)

## QUESTION 3 ##

destFile <- "./data/getdata-data-restaurants.xml"
# Set the download URL of the file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"

if(!file.exists(destFile)) {  
  # Download the file and tell it where to go
  download.file(fileUrl, destfile=destFile, method="curl")
  
  # Get the date the file was downloaded
  dateDownloaded <- date()
  dateDownloaded
}

# Read the data into a variable
doc <- xmlTreeParse(destFile, useInternal=TRUE)
rootNode <- xmlRoot(doc)

# Use the XPath to get to the zipcode
zipcodes <- xpathSApply(rootNode, "//row/zipcode", xmlValue)

# Turn this into a data.table to work with it
DT1 <- data.table(x=zipcodes)
table(DT1[DT1$x=="21231"])

## QUESTION 5 ##

destFile <- "./data/getdata-data-ss06pid.csv"
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"

if(!file.exists(destFile)) {
  
  # Download the file and tell it where to go
  download.file(fileUrl, destfile=destFile, method="curl")
  
  # Get the date the file was downloaded
  dateDownloaded <- date()
  dateDownloaded
}

DT <- fread(destFile)

# Calculate the average value of pwgtp15
ptm <- proc.time()
rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
proc.time() - ptm

ptm <- proc.time()
mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
proc.time() - ptm
            
ptm <- proc.time()
sapply(split(DT$pwgtp15,DT$SEX),mean)
proc.time() - ptm
            
ptm <- proc.time()
mean(DT$pwgtp15,by=DT$SEX)
proc.time() - ptm
            
ptm <- proc.time()
DT[,mean(pwgtp15),by=SEX]
proc.time() - ptm

ptm <- proc.time()
tapply(DT$pwgtp15,DT$SEX,mean)
proc.time() - ptm

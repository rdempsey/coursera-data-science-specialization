# Import required libraries
library(xlsx)

# Set the working directory
setwd("/Users/robertdempsey/Dev/coursera-data-science-specialization/getting-and-cleaning-data/Week 1")

# Ensure the data directory exists. If not, create it.
if(!file.exists("data")) {
  dir.create("data")
}

# Set the download URL of the file
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"

# Download the file and tell it where to go
download.file(fileUrl, destfile="./data/cameras.xlsx", method="curl")

# Make sure it made it
list.files("./data")

# Get the date the file was downloaded
dateDownloaded <- date()
dateDownloaded

# Read the data into a variable
cameraData <- read.xlsx2("./data/cameras.xlsx", sheetIndex = 1, header = TRUE)
# Let's check out some of the data
head(cameraData)

# Read only part of the file to create a subset
colIndex <- 2:3
rowIndex <- 1:4
cameraDataSubset <- read.xlsx("./data/cameras.xlsx", sheetIndex = 1, header = TRUE, colIndex = colIndex, rowIndex = rowIndex)
cameraDataSubset
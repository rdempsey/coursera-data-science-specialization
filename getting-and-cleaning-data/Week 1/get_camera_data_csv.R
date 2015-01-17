# Set the working directory
setwd("/Users/robertdempsey/Dev/coursera-data-science-specialization/getting-and-cleaning-data/Week 1")

# Ensure the data directory exists. If not, create it.
if(!file.exists("data")) {
  dir.create("data")
}

# Set the download URL of the file
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"

# Download the file and tell it where to go
download.file(fileUrl, destfile="./data/cameras.csv", method="curl")

# Make sure it made it
list.files("./data")

# Get the date the file was downloaded
dateDownloaded <- date()
dateDownloaded

# Read the data into a variable
cameraData <- read.table("./data/cameras.csv", sep = ",", header = TRUE, nrows = 80)
# Let's check out some of the data
head(cameraData)

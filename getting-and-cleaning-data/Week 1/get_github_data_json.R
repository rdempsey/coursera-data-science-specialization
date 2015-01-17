# Import the required libraries
library(jsonlite)
# Set the working directory
setwd("/Users/robertdempsey/Dev/coursera-data-science-specialization/getting-and-cleaning-data/Week 1")

# Ensure the data directory exists. If not, create it.
if(!file.exists("data")) {
  dir.create("data")
}

# Set the download URL of the file
fileUrl <- "https://api.github.com/users/jtleek/repos"

# Download the file and tell it where to go
download.file(fileUrl, destfile="./data/github-data.json", method="curl")

# Make sure it made it
list.files("./data")

# Get the date the file was downloaded
dateDownloaded <- date()
dateDownloaded

# Read the data into a variable
jsonData <- fromJSON(fileUrl)

# Get the high-level names
names(jsonData)

# Get the names for the owner element
names(jsonData$owner)

# Get the value for the owner's login
jsonData$owner$login

# Turn a dataset into a json dataset
myjson <- toJSON(iris, pretty=TRUE)
cat(myjson)

# Convert json into a dataset
iris2 <- fromJSON(myjson)
head(iris2)

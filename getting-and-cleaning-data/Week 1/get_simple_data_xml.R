# Import the required libraries
library(XML)
# Set the working directory
setwd("/Users/robertdempsey/Dev/coursera-data-science-specialization/getting-and-cleaning-data/Week 1")

# Ensure the data directory exists. If not, create it.
if(!file.exists("data")) {
  dir.create("data")
}

# Set the download URL of the file
fileUrl <- "http://www.w3schools.com/xml/simple.xml"

# Download the file and tell it where to go
download.file(fileUrl, destfile="./data/simple.xml", method="curl")

# Make sure it made it
list.files("./data")

# Get the date the file was downloaded
dateDownloaded <- date()
dateDownloaded

# Read the data into a variable
doc <- xmlTreeParse(fileUrl, useInternal=TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)

# Access the first food element
rootNode[[1]]

# Subset, like a list
rootNode[[1]][[1]]

# Extract parts of the file
# Loop through the elements of the rootNode and get the xml value
# Get more specific using XPath
xmlSApply(rootNode,xmlValue)

# Get the menu items and prices
xpathSApply(rootNode, "//name", xmlValue)
xpathSApply(rootNode, "//price", xmlValue)


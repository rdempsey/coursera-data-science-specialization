# Import our libraries
library(RMySQL)

# Set the working directory
setwd("~/Dev/coursera-data-science-specialization/getting-and-cleaning-data/Week 2")

# Create a connection
uscsDb <- dbConnect(MySQL(), user="genome", host="genome-mysql.cse.ucsc.edu")
# Run a query against the database and then disconnect
result <- dbGetQuery(uscsDb, "show databases;"); dbDisconnect(uscsDb);
# Show the tables
result

# Connecting to hg19 and listing tables
hg19 <- dbConnect(MySQL(), user="genome", db="hg19", host="genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)
length(allTables)
allTables[1:5]

# Get the dimensions of a specific table, and then the row count
dbListFields(hg19, "affyU133Plus2")
dbGetQuery(hg19, "Select count(*) from affyU133Plus2")

# Read a table
affyData <- dbReadTable(hg19, "affyU133Plus2")
head(affyData)

# Select a specific subset
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query); quantile(affyMis$misMatches)

# Get only a little bit of data from our query
affyMisSmall <- fetch(query, n=10); dbClearResult(query);
dim(affyMisSmall)

# Close the connection
dbDisconnect(hg19)

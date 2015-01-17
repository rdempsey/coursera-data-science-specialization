# Week 2 Quiz

# Libraries we'll use
library(httr)
library(jsonlite)
library(sqldf)
library(XML)
library(data.table)
# Set the working directory
setwd("~/Dev/coursera-data-science-specialization/getting-and-cleaning-data/Week 2")

# Question 1

client_id = "15d82642213fe991cc34"
client_secret = "e26d3205d199009d0f50c9b55be9102f3e78a9c4"
user_to_check = "https://api.github.com/users/jtleek/repos"

oauth_endpoints("github")
myapp <- oauth_app("github", client_id)
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

gtoken <- config(token = github_token)
req <- GET(user_to_check, gtoken)
stop_for_status(req)
content(req)

# Question 2

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
destfile <- "./data/getdata-data-ss06pid.csv"
download.file(fileUrl, destfile=destfile, method="curl")
acs <- read.csv(destfile)
bigdf <- sqldf("select pwgtp1 from acs where AGEP < 50")

# Question 3

acs_unique <- unique(acs$AGEP)
bigdf_unique <- sqldf("select distinct AGEP from acs")

# Question 4

fileURL = "http://biostat.jhsph.edu/~jleek/contact.html"
con = url(fileURL)
htmlcode = readLines(con)
nchar(htmlcode[10])
nchar(htmlcode[20])
nchar(htmlcode[30])
nchar(htmlcode[100])

# Question 5

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
destfile <- "./data/getdata-wksst8110.for"
download.file(fileURL, destfile=destfile, method="curl")

mydata <- read.fwf(file=destfile, skip=4, widths=c(12,7,4,9,4,9,4,9,4))
head(mydata)

# Sum the numbers in the V4 and V9 columns
dt = data.table(mydata)

c1 <- dt[, lapply(.SD, sum, na.rm=TRUE), .SDcols=c("V4") ]
c1

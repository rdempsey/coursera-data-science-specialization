# Working with web data

# Libraries we'll use
library(XML)

# Set the working directory
setwd("~/Dev/coursera-data-science-specialization/getting-and-cleaning-data/Week 2")

url_to_scrape = "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"

# Using readlines
con = url(url_to_scrape)
htmlCode = readLines(con)
close(con)
htmlCode

# Using XML
html <- htmlTreeParse(url_to_scrape, useInternalNodes = T)
xpathSApply(html, "//title", xmlValue)
citations <- xpathSApply(html, "//td[@class='gsc_rsb_std']", xmlValue)
citations[1]

# GET from the httr package
# Useful when accessing password protected websites
library(httr)
html2 = GET(url_to_scrape)
content2 = content(html2, as="text")
parsedHTML = htmlParse(content2, asText=TRUE)
xpathSApply(parsedHTML, "//title", xmlValue)

# Accessing websites with passwords usign httr
pg1 = GET("http://httpbin.org/basic-auth/user/passwd", authenticate("user", "passwd"))
pg1
names(pg1)

# Using handles
# Use these to save authentication across websites, and more
google = handle("http://www.google.com")
pg2 = GET(handle=google,path="/")
pg3 = GET(handle=google,path="search")
# Working with apis

# Libraries we'll use
library(httr)
library(jsonlite)

# Set the working directory
setwd("~/Dev/coursera-data-science-specialization/getting-and-cleaning-data/Week 2")

myapp = oauth_app("twitter",
                  key = "kce73UGmX3wtx3RQDsh6Q",
                  secret = "c5XZHgyQHqdMoU2WbOhh1DEJxLyZIUJgmb9dONz0")
sig = sign_oauth1.0(myapp,
                    token = "4291171-ocZRsP5bAODwxoUxyd4zwIP2sBfm4eHChZdrV26ohc",
                    token_secret = "oqMU4ICuccL88Jqy9n1AjQiGhajUKOBTHumdcOc")
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)

# Convert the JSON object
json1 = content(homeTL)
# Reformat as a data frame
json2 = fromJSON(toJSON(json1))
json2[1,1:4]


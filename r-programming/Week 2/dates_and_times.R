# Dates

x <- as.Date("1970-01-01")
x
unclass(x)
unclass(as.Date("1970-01-02"))

# Times

# POSIXct - very large integer under the hood
# POSIXlt - list underneath, stores day of the week, day of the year, month, day of the month
# Keeps track of leap years, leap seconds, daylight savings and time zones

x <- Sys.time()
x
p <- as.POSIXlt(x)
names(unclass(p))
p$sec
p$wday
p$yday
p$zone

# Convert a written date to a POSIXlt
# Use ?strptime for help
datestring <- c("January 11, 2015 17:29")
x <- strptime(datestring, "%B %d, %Y %H:%M")
x
class(x)

# To do date math, you need both variables to be in the same format


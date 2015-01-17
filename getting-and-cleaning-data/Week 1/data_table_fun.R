# Load the data.table library
library(data.table)

# Create a data frame
DF = data.frame(x=rnorm(9), y=rep(c("a", "b", "c"), each=3), z=rnorm(9))
head(DF,3)

# Create a data table
DT = data.table(x=rnorm(9), y=rep(c("a", "b", "c"), each=3), z=rnorm(9))
head(DT, 3)

# See all data tables in memory
tables()

# Get a subset of rows
DT[2,]
DT[DT$y=="a"]

# Subset rows
DT[c(2,3)]

# Calculate values for variables
DT[,list(mean(x), sum(z))]

# Get a table of y values
DT[,table(y)]

# Adding new columns, without creating a new copy
# If you want a new copy, use the copy function
DT[,w:=z^2]
DT

# Perform multiple operations
DT[,m:= {tmp <- (x+z); log2(tmp+5)}]
DT

# plyr-like operations
DT[,a:=x>0]
DT

# Perform the operation grouping by a
# Runs 2x: once for TRUE and once for FALSE
DT[,b:=mean(x+w), by=a]
DT

# Count the number of times something appears
set.seed(123)
DT <- data.table(x=sample(letters[1:3], 1E5, TRUE))
DT[, .N, by=x]

# Set the key
# Allows for much faster sorting
DT <- data.table(x=rep(c("a", "b","c"), each=100), y=rnorm(300))
setkey(DT, x)
DT['a']

# Joins, using keys
# Very fast if you have the same key for both data tables
DT1 <- data.table(x=c('a', 'a', 'b', 'dt1'), y=1:4)
DT2 <- data.table(x=c('a', 'b', 'dt2'), z=5:7)
setkey(DT1, x)
setkey(DT2,x)
merge(DT1,DT2)

# Fast reading
big_df <- data.frame(x=rnorm(1E6), y=rnorm(1E6))
file <- tempfile()
write.table(big_df, file=file, row.names=FALSE, col.names=TRUE, sep="\t", quote=FALSE)
system.time(fread(file))
# Compare it to reading the file itself
system.time(read.table(file, header=TRUE, sep="\t"))
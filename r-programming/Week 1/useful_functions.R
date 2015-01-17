# Useful Functions

# Get the max value of a column
colMax <- function(data) sapply(data, max, na.rm = TRUE)

# Omit rows with NA in a specified column
# Use: omitNaRows(dataframe, "row name")
omitNaRows <- function(data, desiredCols) {
  completeVec <- complete.cases(data[, desiredCols])
  return(data[completeVec, ])
}
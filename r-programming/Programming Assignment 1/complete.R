complete <- function(directory, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        
        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return a data frame of the form:
        ## id nobs
        ## 1  117
        ## 2  1041
        ## ...
        ## where 'id' is the monitor ID number and 'nobs' is the
        ## number of complete cases

        # Pre-allocate the number of rows for performance
        row_len <- length(id)
        complete_observations <- data.frame(id = numeric(row_len), nobs = numeric(row_len))
        
        x <- 1
        # Get the values out of each sheet
        for(i in id) {
                # Get the correct name of the file
                if(i < 10){
                        filename <- paste("00",i,".csv",sep="")
                } else if (i >= 10 && i <= 99) {
                        filename <- paste("0",i,".csv",sep="")
                } else {
                        filename <- paste(i,".csv",sep="")
                }
                # Create the full path to the file to open it
                file <- paste(directory,"/", filename, sep="")
                # Create a dataframe from the CSV file
                data <- read.csv(file)
                # Add the id and the count of complete cases to the data frame
                complete_observations$id[x] <- i
                complete_observations$nobs[x] <- sum(complete.cases(data))
                x <- x+1
        }
        complete_observations
}
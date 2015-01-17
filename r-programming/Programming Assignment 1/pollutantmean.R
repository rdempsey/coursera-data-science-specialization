pollutantmean <- function(directory, pollutant, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        
        ## 'pollutant' is a character vector of length 1 indicating
        ## the name of the pollutant for which we will calculate the
        ## mean; either "sulfate" or "nitrate".
        
        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return the mean of the pollutant across all monitors list
        ## in the 'id' vector (ignoring NA values)

        observations <- vector()
        
        # Get the values out of each sheet
        for(i in id) {
                msg <- paste("Getting the values of ",pollutant," from file id ",i)
                print(msg)
                # Get the full name of the CSV file to open it
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
                # Get the column index for the given pollutant in our data frame
                # We're assuming they spell the pollutant correctly
                col <- grep(pollutant, colnames(data))
                # Get the number of rows in the sheet
                nrows <- nrow(data)
                for(obs in 1:nrows) {
                        observations <- c(observations, data[obs,col])
                }
        }
        # Return the mean of the observations
        mean(observations, na.rm=TRUE)
        
}
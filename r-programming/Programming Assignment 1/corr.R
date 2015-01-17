corr <- function(directory, threshold = 0) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        
        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0
        
        ## Return a numeric vector of correlations
        
        ## Example
        #> duration = faithful$eruptions   # the eruption durations 
        #> waiting = faithful$waiting      # the waiting period 
        #> cor(duration, waiting)          # apply the cor function
        
        # Identify the files to read
        files_to_process <- list.files(path = directory, pattern = "*.csv", all.files = TRUE)
        
        # For each file, find out of the number of complete cases is greater than
        # the threshold. If it is, add it to our complete_observations
        
        # Counter
        i <- 1
        # Create an empty vector to hold our list of correlations
        list_of_cors <- vector()
        
        for(f in files_to_process) {
                # Get the full path to the file
                file <- paste(directory,"/", f, sep="")
                # Read in the contents
                data <- read.csv(file)
                # See if the complete cases is greater than the threshold
                #print(sum(complete.cases(data)))
                if(sum(complete.cases(data)) > threshold) {
                        # Add the complete rows to a new data.frame
                        complete_observations <- data[complete.cases(data),]
                        # Run the correlation on sulfate and nitrate on the complete observations
                        sulfate <- complete_observations$sulfate
                        nitrate <- complete_observations$nitrate
                        # Add the correlation to our list
                        c <- cor(sulfate, nitrate)
                        #list_of_cors[i] <- round(c, digits=5)
                        list_of_cors[i] <- c
                        # Increment our counter
                        i <- i + 1
                }
        }
        
        if(length(list_of_cors) == 0) {
                numeric(length = 0)        
        } else {
                list_of_cors
        }
}
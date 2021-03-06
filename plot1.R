## plot1.R
##
## Author: Ted Randall
## Date: 2/5/2015

## Setup filename constants
data_source_url <- "https://d396qusza40orc.cloudfront.net/exdata/data/"
data_zip_filename <- "household_power_consumption.zip"
data_filename <- "household_power_consumption.txt"
output_filename <- "plot1.png"

## Check if the data file exists
if (!file.exists(data_filename)) {
    ## Check is the zip file exists
    if (!file.exists(data_zip_filename)) {
        ## If zip file doens't exist, download it
        download.file(paste(data_source_url,data_zip_filename,sep=""), data_zip_filename)
    }
    ## If data file doesn't exist, unzip it
    unzip(data_zip_filename, junkpaths=TRUE)
}

## Read the data file into a data frame
df <- read.csv(data_filename, header = TRUE, sep = ";", 
               dec = ".", na.strings = "?", 
               colClasses = c("character", "character", 
                              "numeric", "numeric", "numeric", 
                              "numeric", "numeric", "numeric", 
                              "numeric"))

## Subset the data to include only "2/2/2007" and "1/2/2007"
df <- df[df$Date == "2/2/2007" | df$Date == "1/2/2007",]

## Set plot output to png device
png(filename=output_filename, width = 480, height = 480, bg="transparent")

## Plot the data
hist(df$Global_active_power, col="Red", main="Global Active Power",
     xlab="Global Active Power (kilowatts)")

## Close png device
dev.off()

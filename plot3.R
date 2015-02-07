## plot3.R
##
## Author: Ted Randall
## Date: 2/5/2015

## Setup filename constants
data_source_url <- "https://d396qusza40orc.cloudfront.net/exdata/data/"
data_zip_filename <- "household_power_consumption.zip"
data_filename <- "household_power_consumption.txt"
output_filename <- "plot3.png"

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

## Combine "Date" and "Time" columns to a single datetime column
Sys.setlocale("LC_TIME", "C")
df$datetime <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %X")

## Set plot output to png device
png(filename=output_filename, width = 480, height = 480, bg="transparent")

## Create the plot
plot(df$datetime, df$Sub_metering_1, type="l", xlab="",
     ylab="Energy sub metering")
points(df$datetime, df$Sub_metering_2, type="l", col="Red")
points(df$datetime, df$Sub_metering_3, type="l", col="Blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("Black", "Red", "Blue"), lty=1)

## Close png device
dev.off()

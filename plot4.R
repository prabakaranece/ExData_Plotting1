# Plotting Assignment 1 for Exploratory Data Analysis  

# Refs
# http://archive.ics.uci.edu/ml/
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

#Tasks
#Tasks
#Goal here is simply to examine how household energy usage varies over a 2-day period (2007-02-01 and 2007-02-02)
# 1) Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
# 2) Name of the plot file as plot4.png
# 3) Create a separate R code file (plot4.R) that constructs the corresponding plot, i.e. code in plot4.R constructs the plot4.png plot. Your code file should include code for reading the data so that the plot can be fully reproduced. You must also include the code that creates the PNG file.

#a. cleanup
rm(list = ls())

#b. download and unzip data
baseDir <- "."

#b.1 create data sub directory if doesn't exist
dataDir <- paste(baseDir, "data", sep = "/")
if(!file.exists(dataDir)){
  dir.create(dataDir)
}

#b.2 download dataset if doen't exist
zipFilePath <- paste(dataDir, "Dataset.zip", sep = "/")
if(!file.exists(zipFilePath)){
  zipFileUlr <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(zipFileUlr, zipFilePath)
  dateDownloaded <- date()
  cat("Dataset downloaded on:", dateDownloaded,"\n")
}

#b.3 unzip and create data directory if doesn't exist
dataSetDir <- paste(dataDir, "household_power_consumption", sep = "/")
if(!file.exists(dataSetDir)){
  unzip(zipFilePath, exdir = dataSetDir)
}
list.files(dataSetDir)

#c read the datasets
hpcPath <- paste(dataSetDir, "household_power_consumption.txt", sep = "/")
hpc <- read.table(hpcPath, header=T, sep=';', stringsAsFactors=F, dec = ".")

#c.1 filter data
subSetHpc <- hpc[hpc$Date %in% c("1/2/2007","2/2/2007"), ]

#D. plot
globalActivePower <- as.numeric(subSetHpc$Global_reactive_power)
datetime <- strptime(paste(subSetHpc$Date, subSetHpc$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
globalReactivePower <- as.numeric(subSetHpc$Global_reactive_power)
voltage <- as.numeric(subSetHpc$Voltage)
subMetering1 <- as.numeric(subSetHpc$Sub_metering_1)
subMetering2 <- as.numeric(subSetHpc$Sub_metering_2)
subMetering3 <- as.numeric(subSetHpc$Sub_metering_3)

png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 
plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.2)
plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")

plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

plot(datetime, globalReactivePower, type="l", xlab="datetime", ylab="Global Reactive Power")
dev.off()

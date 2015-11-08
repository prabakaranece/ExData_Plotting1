# Plotting Assignment 1 for Exploratory Data Analysis  

# Refs
# http://archive.ics.uci.edu/ml/
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

#Tasks
#Goal here is simply to examine how household energy usage varies over a 2-day period (2007-02-01 and 2007-02-02)
# 1) Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
# 2) Name of the plot file as plot1.png
# 3) Create a separate R code file (plot1.R) that constructs the corresponding plot, i.e. code in plot1.R constructs the plot1.png plot. Your code file should include code for reading the data so that the plot can be fully reproduced. You must also include the code that creates the PNG file.

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
png("plot1.png", width=480, height=480)
hist(globalActivePower, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()

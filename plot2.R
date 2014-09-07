######plot2.R ##################
#############################################################
#### Project1 Exploratory data Analysis  ####################
#############################################################
####### by Arundhati Kulkarni################################



## shuts down all opened grphic devices
graphics.off()

## Get the current working directory and if the data file doesnot
## exist in the directory then download and unzip it.

currentWorkingDirectory <- getwd()
unzippedFilePath <- paste(currentWorkingDirectory,"household_power_consumption.txt",sep="/")
if(!file.exists(unzippedFilePath)){
  fileUrl1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl1, destfile = "household_power_consumption.zip", method = "auto")
  dirFilePath <- paste(currentWorkingDirectory,"household_power_consumption.zip",sep="/")
  unzip(dirFilePath);
}

###Reading dataset
data <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
# converts character date into Date class
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

## Subsetting the data from whole data that read above
data_sub <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data)

## Converting dates
datetime <- paste(as.Date(data_sub$Date), data_sub$Time)
data_sub$Datetime <- as.POSIXct(datetime)

## draw Plot 2 
plot(data_sub$Global_active_power~data_sub$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="day")
## saving plot created in png file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
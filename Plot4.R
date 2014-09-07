###### plot4.R ##################
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


#Reading dataset
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

## drawing Plot 4

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

with(data_sub,{
  
plot(Global_active_power~Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")

plot(Voltage~Datetime,type="l",
     ylab = "Voltage",xlab="Datetime")

plot(Sub_metering_1~Datetime,type="l",
        ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~Datetime,col='Red')
        lines(Sub_metering_3~Datetime,col='Blue')


plot(Global_reactive_power~Datetime,type="l",
     ylab = "Global_reactive_power",xlab="Datetime")

})
## saving created plot to a png file  
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
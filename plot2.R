#This script will set the working directory, get the needed data, and run the
#necessary R code to create the desired plots for Course Project 1 - Plot 2

#Set working directory
setwd("~/R/Classes/4 Expoloratory Data Analysis/project 1")

#Get the row classes to speed up read
tab5rows <- read.table("household_power_consumption.txt", header = TRUE,
                       sep = ";", nrows = 5, na.strings = "?")
classes <- sapply(tab5rows, class)

#Ready in data
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", 
                   colClasses = classes, comment.char = "", na.strings = "?")

#Get only the 2 dates we need
usedata <- subset(data, Date == '1/2/2007' | Date == '2/2/2007')

#Change first column to date class
usedata[,1] <- as.Date(strptime(usedata[,1],"%d/%m/%Y"))

#Create a column with data/time together
usedata[,"DateTime"] <- as.POSIXct(paste(usedata$Date, usedata$Time),
                                   format="%Y-%m-%d %H:%M:%S")

#Open the PNG graphics device
png(file="plot2.png")

#Create the line plot
plot(usedata$DateTime,usedata$Global_active_power, type="l", xlab = "",
     ylab = "Global Active Power (kilowatts)")

#Close the graphics device
dev.off()
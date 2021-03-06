#This script will set the working directory, get the needed data, and run the
#necessary R code to create the desired plots for Course Project 1 - Plot 3

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
png(file="plot3.png")

#Create the base line plot with the first variable
plot(usedata$DateTime,usedata$Sub_metering_1, type="l", xlab = "",
     ylab = "Energy sub metering")

#Add sub_metering_2 as RED line
points(usedata$DateTime,usedata$Sub_metering_2, col = "red", type="l")

#Add sub_metering_3 as BLUE line
points(usedata$DateTime,usedata$Sub_metering_3, col = "blue", type="l")

#Add legend
legend("topright", lty = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Close the graphics device
dev.off()
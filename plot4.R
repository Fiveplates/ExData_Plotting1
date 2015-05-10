### Coursera - John Hopkins University
### Data Science Specialisation Track
### R Programming

### 10 May 2015

### Course Project 1


### Plot 4

### This assignment uses data from the UC Irvine Machine Learning Repository, a popular repository for machine learning
### datasets. In particular, we will be using the “Individual household electric power consumption Data Set” which is 
### available on the course web site:

### Dataset:     Electric power consumption 
###              https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip  [20Mb]

### Description: Measurements of electric power consumption in one household with a one-minute sampling rate over a 
###              period of almost 4 years. Different electrical quantities and some sub-metering values are available.

### The following descriptions of the 9 variables in the dataset are taken from the UCI web site:

### Date:                       Date in format dd/mm/yyyy
### Time:                       time in format hh:mm:ss
### Global_active_power:        household global minute-averaged active power (in kilowatt)
### Global_reactive_power:      household global minute-averaged reactive power (in kilowatt)
### Voltage:                    minute-averaged voltage (in volt)
### Global_intensity:           household global minute-averaged current intensity (in ampere)
### Sub_metering_1:             energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the 
###                             kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not 
###                             electric but gas powered).
### Sub_metering_2:             energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the 
###                             laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light
### Sub_metering_3:             energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an 
###                             electric water-heater and an air-conditioner.


### Loading the Data

library(data.table)


classes <- c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")

### Load a subset of the data, which is required for creating the plots
### The sampling rate is every minute, 1440 samples per day (from 01/02/2007); therefore two days requires reading
### 2880 samples
epcDF <- fread("./data/household_power_consumption.txt", sep = ";", skip = "1/2/2007", nrows = 2880,
               colClasses = classes, na.strings = c("?")) 

### Assign the column names to vector colNames
colNames <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", 
              "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

setnames(epcDF, colNames) ## Set Column Names in the dataset

### Create DateTime variable from the Date and Time variables in the epConsumption dataset
epcDF$DateTime <- as.POSIXct(paste(epcDF$Date, epcDF$Time), format = "%d/%m/%Y %H:%M:%S")


### Plot Days and Global Active Power - smooth line through the data points

par(mfrow = c(2, 2))  ## use mfrow equal to two rows and two columns

with(epcDF, {
        ### Create plot 1 - row = 1, col = 1
        plot(epcDF$DateTime, epcDF$Global_active_power, xlab = "", ylab = "Global Active Power", type = "l")
        
        ### Create plot 2 - row = 1, col = 2
        plot(epcDF$DateTime, epcDF$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
        
        ### Create plot 3 - row = 2, col = 1
        plot(epcDF$DateTime, epcDF$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
        lines(epcDF$DateTime, epcDF$Sub_metering_2, type = "l", col = "red")
        lines(epcDF$DateTime, epcDF$Sub_metering_3, type = "l", col = "blue")
        legend("topright", lty = "solid", col = c("black", "red", "blue"),
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        
        ### Create plot 4 - row = 2, col = 2
        plot(epcDF$DateTime, epcDF$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l")
})

dev.copy(png, file = "plot4.png") ## Copy the plot to a PNG file
dev.off() ## close the PNG device





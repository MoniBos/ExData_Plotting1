library(sqldf)	#require necessary libraries
library(timeDate)
library(lubridate)

setwd("C:/Users/...")
power<-read.csv("household_power_consumption.txt",header=TRUE, sep=";", na.strings="?")	##read data

power$Date <- as.Date(power$Date, format="%d/%m/%Y")
power$Date1<-as.character(as.Date(as.character(power$Date)))

sub<-sqldf('select * from power where Date1 between "2007-02-01" and "2007-02-02"')		##select subset of data

##plot
png("plot1.png", width=480, height=480)
hist(sub$Global_active_power, col="red", xlab="Global Active Power(kilowatts)", main="Global Active Power")
dev.off()

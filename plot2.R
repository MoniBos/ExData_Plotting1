##plot2
library(sqldf)	#require necessary libraries
library(sqldf)
library(timeDate)

setwd("C:/Users/...")			
power<-read.csv("household_power_consumption.txt",header=TRUE, sep=";", na.strings="?")   ##read data

power$Date <- as.Date(power$Date, format="%d/%m/%Y")		 ##change date format
power$Date1<-as.character(as.Date(as.character(power$Date)))

sub<-sqldf('select * from power where Date1 between "2007-02-01" and "2007-02-02"')		##select subset of data

datetime <- paste(as.Date(sub$Date1), sub$Time)
sub$Datetime <- as.POSIXct(datetime)

##plot
png("plot2.png", width=480, height=480)
plot(sub$Global_active_power~sub$Datetime, type="l", xlab="",ylab="Global Active Power(kilowatts)")
dev.off()

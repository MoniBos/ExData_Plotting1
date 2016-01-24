library(sqldf)	#require necessary libraries
library(sqldf)
library(timeDate)

setwd("C:/Users/...")
power<-read.csv("household_power_consumption.txt",header=TRUE, sep=";", na.strings="?") ##read data

power$Date <- as.Date(power$Date, format="%d/%m/%Y")     ##change date format
power$Date1<-as.character(as.Date(as.character(power$Date)))

sub<-sqldf('select * from power where Date1 between "2007-02-01" and "2007-02-02"')   ##select subset of data

datetime <- paste(as.Date(sub$Date1), sub$Time)
sub$Datetime <- as.POSIXct(datetime)

#plot
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2), mar=c(4,4,2,1))
with(sub,{
	plot(sub$Global_active_power~sub$Datetime, type="l", xlab="",ylab="Global Active Power")
	plot(sub$Voltage~sub$Datetime, type="l", xlab="datetime",ylab="Voltage")
	plot(sub$Sub_metering_1~sub$Datetime, type="l", xlab="",ylab="Energy sub metering")
	lines(sub$Sub_metering_2~sub$Datetime, type="l", xlab="",ylab="Energy sub metering",ylim=c(0,30), col="red")
	lines(sub$Sub_metering_3~sub$Datetime, type="l", xlab="",ylab="Energy sub metering", ylim=c(0,30),col="blue")
	legend("topright",bty="n", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue") )
	plot(sub$Global_reactive_power~sub$Datetime, type="l", xlab="datetime",ylab="Global_reactive_power")
	
})
dev.off()

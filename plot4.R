##Plot4
#Download and read files
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,"data.zip", method="curl")
unzip(zipfile="data.zip")
consumption<-read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?", stringsAsFactors=FALSE)

#summary of variables
str(consumtion)

#Transform classes of columns Date and Time into date and time instead character
consumption$Date<-strptime(paste(consumption$Date, consumption$Time), "%d/%m/%Y %H:%M:%S")
#Select the first two days of February and store in a new variable
cons_sub<-subset(consumption, Date>=as.POSIXlt("2007-02-01")&Date<as.POSIXlt("2007-02-03"))
# Set locale date format in English (I am from Spain)
Sys.setlocale("LC_TIME","English")

#Represent the plot
par(mfrow=c(2,2),cex=0.5)
with(cons_sub,{
  plot(Date,Global_active_power, type="l",xlab="", ylab="Global Active Power")
  plot(Date, Voltage, type="l",xlab="datetime",ylab="Voltage")
  plot(Date,Sub_metering_1, type="l",xlab="", ylab="Energy sub metering", main="", col="black", cex=0.25)
  lines(Date, Sub_metering_2, type="l", col="red")
  lines(Date, Sub_metering_3,type="l", col="blue")
  legend("topright",lty=1, cex=0.5, legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"))
  plot(Date,Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
  }
)


#Save the histogram into a png file
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()


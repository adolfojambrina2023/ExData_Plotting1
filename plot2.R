##Plot2
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
#Plot Global Active Power~Date
plot(cons_sub$Date,cons_sub$Global_active_power, type="l",xlab="", ylab="Global Active Power (kilowatts)")

#Save the histogram into a png file
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()


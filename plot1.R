# load file
library("data.table")

powerdata<- data.table::fread(input = "household_power_consumption.txt", na.strings="?")
# trim time 2007-02-01 to 2007-02-02
powerdata[, Date := strptime(Date, "%d/%m/%Y")]

powerdata <- powerdata[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

# plotting
# 1
png("plot1.png", width=480, height=480)
hist(powerdata[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
dev.off()

# 2
# change time format
powerdata[, datetime := as.POSIXct(paste(Date, Time), format = "%Y-%m-%d %H:%M:%S")]
# plot
png("plot2.png", width=480, height=480)
plot(x = powerdata[, datetime], y = powerdata[, Global_active_power], type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

# 3
png("plot3.png", width=480, height=480)

# Plot 3
plot(powerdata[, datetime], powerdata[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(powerdata[, datetime], powerdata[, Sub_metering_2],col="red")
lines(powerdata[, datetime], powerdata[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

dev.off()

# 4
png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))
# top L
plot(powerdata[, datetime], powerdata[, Global_active_power], type="l", xlab="", ylab="Global Active Power")
# top R
plot(powerdata[, datetime], powerdata[, Voltage], type="l", xlab="datetime", ylab="Voltage")
# bottom L
plot(powerdata[, datetime], powerdata[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(powerdata[, datetime], powerdata[, Sub_metering_2], col="red")
lines(powerdata[, datetime], powerdata[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 
# bottom R
plot(powerdata[, datetime], powerdata[, Global_reactive_power], type="l", xlab="datetime", ylab="Global Reactive Power")

dev.off()

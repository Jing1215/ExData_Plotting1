# load file
library("data.table")

powerdata<- data.table::fread(input = "household_power_consumption.txt", na.strings="?")
# trim time 2007-02-01 to 2007-02-02
powerdata[, Date := strptime(Date, "%d/%m/%Y")]

powerdata <- powerdata[(Date >= "2007-02-01") & (Date <= "2007-02-02")]
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
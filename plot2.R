# load file
library("data.table")

powerdata<- data.table::fread(input = "household_power_consumption.txt", na.strings="?")
# trim time 2007-02-01 to 2007-02-02
powerdata[, Date := strptime(Date, "%d/%m/%Y")]

powerdata <- powerdata[(Date >= "2007-02-01") & (Date <= "2007-02-02")]
# 2
# change time format
powerdata[, datetime := as.POSIXct(paste(Date, Time), format = "%Y-%m-%d %H:%M:%S")]
# plot
png("plot2.png", width=480, height=480)
plot(x = powerdata[, datetime], y = powerdata[, Global_active_power], type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

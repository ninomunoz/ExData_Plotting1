file <- "household_power_consumption.txt"

## Read header from file
header <- readLines(file, n = 1)

## Construct dataframe from concatenated header and filtered data
data <- read.table(text = c(header, grep("^[1,2]/2/2007", readLines(file), value = TRUE)), 
                   sep = ";", header = TRUE, na.strings="?")

## Merge date and time columns
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
dateTime <- paste(as.Date(data$Date), data$Time)
data$DateTime <- as.POSIXct(dateTime)

## Open png file device
png(file="plot4.png")

## Generate plot
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(data, {
    plot(Global_active_power ~ DateTime, type = "l", 
         ylab = "Global Active Power", xlab = "")
    plot(Voltage ~ DateTime, type = "l", ylab = "Voltage", xlab = "datetime")
    plot(Sub_metering_1 ~ DateTime, type = "l", ylab = "Energy sub metering",
         xlab = "")
    lines(Sub_metering_2 ~ DateTime, col = 'Red')
    lines(Sub_metering_3 ~ DateTime, col = 'Blue')
    legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
           bty = "n",
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power ~ DateTime, type = "l", 
         ylab = "Global_reactive_power", xlab = "datetime")
})

## Close png file device
dev.off()
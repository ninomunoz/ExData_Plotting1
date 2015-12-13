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
png(file="plot3.png")

## Generate plot
with(data, {
    plot(Sub_metering_1 ~ DateTime, type = "l", 
         ylab = "Global Active Power (kilowatts)", xlab = "")
    lines(Sub_metering_2 ~ DateTime, col = 'Red')
    lines(Sub_metering_3 ~ DateTime, col = 'Blue')
})

## Add legend to plot
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Close png file device
dev.off()
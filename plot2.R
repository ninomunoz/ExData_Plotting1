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
png(file="plot2.png")

## Generate plot
plot(data$Global_active_power ~ data$DateTime, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")

## Close png file device
dev.off()
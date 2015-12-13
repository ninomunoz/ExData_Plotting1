file <- "household_power_consumption.txt"

## Read header from file
header <- readLines(file, n = 1)

## Construct dataframe from concatenated header and filtered data
data <- read.table(text = c(header, grep("^[1,2]/2/2007", readLines(file), value = TRUE)), 
                   sep = ";", header = TRUE, na.strings="?")

## Open png file device
png(file="plot1.png")

## Plot histogram
hist(data$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

## Close png file device
dev.off()
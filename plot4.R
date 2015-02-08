
# Download the zipped file
download.file(
    url =      "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
    destfile = "exdata-data-household_power_consumption.zip"
)

# Extract the raw file from the downloaded archive
rawFile <- unzip("exdata-data-household_power_consumption.zip")

# Read file 
data <- read.table(file = rawFile, stringsAsFactors = FALSE, header = TRUE, sep = ";" , na.strings = "?")

# Subset the 2 days needed for the graphs: 01/02/2007 and 02/02/2007
twoDaysData <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]

# Convert date and time format
twoDaysData$Time <- strptime(paste(twoDaysData$Date, twoDaysData$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")
twoDaysData$Date <- as.Date(twoDaysData$Date, format = "%d/%m/%Y")

# plotting plot4.png
png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "transparent")
par(mfrow = c(2,2))

# plotting the graphs one by one... reusing previous works

# 1 - Top left
plot(twoDaysData$Time, twoDaysData$Global_active_power, col = "black", type = "l", xaxt = "n", xlab= "", ylab = "Global Active Power")
axis(1, at = as.numeric(c(min(twoDaysData$Time), mean(twoDaysData$Time), max(twoDaysData$Time))), labels = c("Thu", "Fri", "Sat"))

# 2 - Top right
plot(twoDaysData$Time, twoDaysData$Voltage, col = "black", type = "l", xaxt = "n", xlab= "datetime", ylab = "Voltage")
axis(1, at = as.numeric(c(min(twoDaysData$Time), mean(twoDaysData$Time), max(twoDaysData$Time))), labels = c("Thu", "Fri", "Sat"))

# 3 - Bottom left
plot(twoDaysData$Time, twoDaysData$Sub_metering_1, type = "l", col = "black", xaxt = "n", xlab = "", ylab = "Energy sub metering")
lines(twoDaysData$Time, twoDaysData$Sub_metering_2, type = "l", col = "red")
lines(twoDaysData$Time, twoDaysData$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lwd = 1, bty = "n")
axis(1, at = as.numeric(c(min(twoDaysData$Time), mean(twoDaysData$Time), max(twoDaysData$Time))), labels = c("Thu", "Fri", "Sat"))

# 4 - Bottom right
plot(twoDaysData$Time, twoDaysData$Global_reactive_power, col = "black", type = "l", xaxt = "n", xlab= "datetime", ylab = "Global_reactive_power")
axis(1, at = as.numeric(c(min(twoDaysData$Time), mean(twoDaysData$Time), max(twoDaysData$Time))), labels = c("Thu", "Fri", "Sat"))

# Close the PNG file
dev.off()


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

# plotting plot3.png
png(filename = "plot3.png", width = 480, height = 480, units = "px", bg = "transparent")

# plotting the lines one by one...
plot(twoDaysData$Time, twoDaysData$Sub_metering_1, type = "l", col = "black", xaxt = "n", xlab = "", ylab = "Energy sub metering")
lines(twoDaysData$Time, twoDaysData$Sub_metering_2, type = "l", col = "red")
lines(twoDaysData$Time, twoDaysData$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lwd = 1)

# Because French system automatically converts day names in French, 
# the result on my computer is not exactly the same than the one wanted in 
# the assignment. So I put the day names manually on the x-axis.
axis(1, at = as.numeric(c(min(twoDaysData$Time), mean(twoDaysData$Time), max(twoDaysData$Time))), labels = c("Thu", "Fri", "Sat"))

# Close the PNG file
dev.off()

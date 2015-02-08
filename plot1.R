
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

## plotting plot1.png
png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "transparent")
hist(twoDaysData$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main ="Global Active Power")

# Close the PNG file
dev.off()


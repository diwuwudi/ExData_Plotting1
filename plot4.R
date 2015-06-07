#This script assumes that the desired data is located in the current working directory

# Load the data
data <- read.table("household_power_consumption.txt", sep=";", header = TRUE)

# Concert Date to "Date" format
data$Date <- as.Date(data$Date, format= "%d/%m/%Y")

# Subset the data based on date
sub <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")

# Remove the original dataset
rm(data)

# Change three columns to numeric
sub$Global_active_power <- as.numeric(paste(sub$Global_active_power))
sub$Sub_metering_1 <- as.numeric(paste(sub$Sub_metering_1))
sub$Sub_metering_2 <- as.numeric(paste(sub$Sub_metering_2))
sub$Sub_metering_3 <- as.numeric(paste(sub$Sub_metering_3))
sub$Voltage <- as.numeric(paste(sub$Voltage))
sub$Global_reactive_power <- as.numeric(paste(sub$Global_reactive_power))

# Create a new column that contains date and time
sub$Date <- as.character(sub$Date)
sub$Time <- as.character(sub$Time)
sub$datetime <- paste(sub$Date, sub$Time)
sub$datetime <- as.POSIXct(sub$datetime, format = "%Y-%m-%d %H:%M:%S")

# Set margin
par(mfrow = c(2,2), mar = c(4,4,2,1))

# First
plot(sub$Global_active_power~sub$datetime, pch = ".", xlab = "", ylab = "Global Active Power")
lines(sub$Global_active_power~sub$datetime)

# Second
plot(sub$Voltage~sub$datetime, pch = ".", xlab = "datetime", ylab = "Voltage")
lines(sub$Voltage~sub$datetime)

# Third
plot(sub$Sub_metering_1~sub$datetime,
     pch = ".", xlab = "", ylab = "Energy sub metering")
lines(sub$Sub_metering_1~sub$datetime)
points(sub$Sub_metering_2~sub$datetime,pch = ".", col = "red")
lines(sub$Sub_metering_2~sub$datetime, col = "red")
points(sub$Sub_metering_3~sub$datetime,pch = ".", col = "blue")
lines(sub$Sub_metering_3~sub$datetime, col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty = c(1,1,1), col=c("black","red", "blue"), lwd = c(1,1,1), bty="n", cex=.5, inset = c(0,0))

# Fourth
plot(sub$Global_reactive_power~sub$datetime, pch = ".", xlab = "datetime", 
     ylab = "Global_reactive_power")
lines(sub$Global_reactive_power~sub$datetime)

# Save the plot
dev.copy(png, file = "plot4.png", height = 480, width = 480)

# Close the PNG device
dev.off()
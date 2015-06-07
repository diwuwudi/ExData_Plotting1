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
sub$Sub_metering_1 <- as.numeric(paste(sub$Sub_metering_1))
sub$Sub_metering_2 <- as.numeric(paste(sub$Sub_metering_2))
sub$Sub_metering_3 <- as.numeric(paste(sub$Sub_metering_3))

# Create a new column that contains date and time
sub$Date <- as.character(sub$Date)
sub$Time <- as.character(sub$Time)
sub$datetime <- paste(sub$Date, sub$Time)
sub$datetime <- as.POSIXct(sub$datetime, format = "%Y-%m-%d %H:%M:%S")

# Draw Plot3
plot(sub$Sub_metering_1~sub$datetime,
     pch = ".", xlab = "", ylab = "Energy sub metering")
lines(sub$Sub_metering_1~sub$datetime)
points(sub$Sub_metering_2~sub$datetime,pch = ".", col = "red")
lines(sub$Sub_metering_2~sub$datetime, col = "red")
points(sub$Sub_metering_3~sub$datetime,pch = ".", col = "blue")
lines(sub$Sub_metering_3~sub$datetime, col = "blue")

# Legend
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty = c(1,1,1), col=c("black","red", "blue"), lwd = c(1,1,1), border = "black", cex=.5)

# Save the plot
dev.copy(png, file = "plot3.png", height = 480, width = 480)

# Close the PNG device
dev.off()
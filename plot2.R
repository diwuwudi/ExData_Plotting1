#This script assumes that the desired data is located in the current working directory

# Load the data 
data <- read.table("household_power_consumption.txt", sep=";", header = TRUE)

# Concert Date to "Date" format
data$Date <- as.Date(data$Date, format= "%d/%m/%Y")

# Subset the data based on date
sub <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")

# Remove the original dataset
rm(data)

# Change data$Global_active_power to numeric
sub$Global_active_power <- as.numeric(paste(sub$Global_active_power))

# Create a new column that contains date and time
sub$Date <- as.character(sub$Date)
sub$Time <- as.character(sub$Time)
sub$datetime <- paste(sub$Date, sub$Time)
sub$datetime <- as.POSIXct(sub$datetime, format = "%Y-%m-%d %H:%M:%S")

# Draw Plot2
plot(sub$Global_active_power~sub$datetime, pch = ".", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(sub$Global_active_power~sub$datetime)

# Save the plot
dev.copy(png, file = "plot2.png", height = 480, width = 480)

# Close the PNG device
dev.off()
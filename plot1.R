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

# draw Plot 1
hist(sub$Global_active_power, col="red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

# Save the plot
dev.copy(png, file = "plot1.png", height = 480, width = 480)

# Close the PNG device
dev.off()

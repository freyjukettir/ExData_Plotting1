# Set working directory
setwd("C:/etc/Data_Science_Specialization/C04_Exploratory_Data_Analysis/W01/exdata_data_household_power_consumption")

# Use data.table for faster import
library(data.table)

# Import data set
df <- fread("household_power_consumption.txt", na.strings = "?", sep = ";")

# Data transformations
# Convert character date to Date class
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")

# Subset to the dates of interest
df <- subset(df, Date >= "2007-02-01" & Date <= "2007-02-02")

# Make a date_time column as POSIXct
date_time <- paste(df$Date, df$Time)
df$date_time <- as.POSIXct(date_time)

# Create day labels for x axis
x_axis_day_labels <- as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03"))

# Preliminaries complete.

# Plot the relationships of concern.
# Base plot, no x axis ticks:
plot(df$Sub_metering_1~df$date_time, type = 'l', xlab = '', xaxt = 'n',
     ylab = 'Energy sub metering', col = 'black')

# Add line for second relationship
lines(df$Sub_metering_2~df$date_time, type = 'l', col = 'red')

# Add line for third relationship
lines(df$Sub_metering_3~df$date_time, type = 'l', col = 'blue')

# Add x axis ticks using day labels created above
axis.POSIXct(side = 1, at = x_axis_day_labels, format = "%a")

# Add legend
legend('topright',
       c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
       col = c('black', 'red', 'blue'), 
       lty = 1)

# Write plot to working directory as .png
dev.copy(png, width = 500, height = 500, 'plot3.png')
dev.off()

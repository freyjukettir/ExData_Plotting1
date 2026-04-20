# Set working directory
setwd("C:/etc/Data_Science_Specialization/C04_Exploratory_Data_Analysis/W01/exdata_data_household_power_consumption")

# Use data.table for faster import
library(data.table)

# Import data set
df <- fread("household_power_consumption.txt", na.strings = "?", sep = ";")

# Data transformations
# convert character date to Date class
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")

# Cut the data set down to the dates of interest
df <- subset(df, Date >= "2007-02-01" & Date <= "2007-02-02")

# Create a date_time column as POSIXct
date_time <- paste(df$Date, df$Time)
df$date_time <- as.POSIXct(date_time)

# Create day labels for x axis
x_axis_day_labels <- as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03"))

# Plot relationship of interest, without x axis ticks
plot(Global_active_power~date_time, df, type = 'l',
     ylab = 'Global Active Power (kilowatts)', 
     xlab = '', xaxt = 'n')

# Add x axis ticks using date labels created above
axis.POSIXct(side = 1, at = x_axis_day_labels, format = "%a")

# Write plot to disc as .png
dev.copy(png, 'plot2.png', width = 500, height = 500)
dev.off()

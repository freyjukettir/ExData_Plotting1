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

# Now to plot:
# Set up the 2x2 layout, and fill by columns
par(mfcol = c(2,2))


# First plot, upper left: plot without x axis ticks
plot(Global_active_power~date_time, df, type = 'l',
     ylab = "Global Active Power", xlab = "", xaxt = "n"
)
# Add x axis ticks with the day labels created above
axis.POSIXct(side = 1, at = x_axis_day_labels, format = "%a")


# Second plot, lower left: plot without x axis ticks
plot(df$Sub_metering_1~df$date_time, type = 'l', 
     xlab = '', xaxt = 'n',
     ylab = 'Energy sub metering', 
     col = 'black')

# Add line for second relationship:
lines(df$Sub_metering_2~df$date_time, type = 'l', col = 'red')

# Add line for third relationship:
lines(df$Sub_metering_3~df$date_time, type = 'l', col = 'blue')

# Add x axis with the day labels created above, specifying format as abbreviated
# day name
axis.POSIXct(side = 1, at = x_axis_day_labels, format = "%a")

# Add legend, no border
legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
       col = c('black', 'red', 'blue'), 
       lty = 1, bty = 'n')


# Third plot, upper right, no x axis ticks:
plot(df$Voltage~df$date_time, type = 'l', xlab = 'datetime', xaxt = 'n',
     ylab = 'Voltage')

# Add x axis ticks with the day labels created above
axis.POSIXct(side = 1, at = x_axis_day_labels, format = "%a")


# Fourth plot, lower right, no x axis ticks:
plot(Global_reactive_power~date_time, df, type = 'l', 
     xlab = 'datetime', xaxt = 'n')

# Add x axis ticks with the day labels created above
axis.POSIXct(side = 1, at = x_axis_day_labels, format = "%a")

# And write out to .png in working directory:
dev.copy(png, 'plot4.png')
dev.off()
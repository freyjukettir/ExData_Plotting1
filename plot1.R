# Set working directory
setwd("C:/etc/Data_Science_Specialization/C04_Exploratory_Data_Analysis/W01/exdata_data_household_power_consumption")

# Large number of observations, so read.table will be faster than read.csv2
library(data.table)

# Import data set
df <- fread("household_power_consumption.txt", na.strings = "?", sep = ";")

# Data transformations
# Convert character date to Date class
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")

# Subset to dates of interest
df <- subset(df, Date >= "2007-02-01" & Date <= "2007-02-02")

# Plot histogram of global active power, with suitable cosmetic adjustments:
hist(df$Global_active_power, col = 'red', main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

# Write plot to disc as .png
dev.copy(png, 'plot1.png')
dev.off()

library(dplyr)

## Check for data directory and create directory if it doesn't exist

if (!file.exists("Assignment_Data")) {
    dir.create("Assignment_Data")
}

## Download the data set, unzip the file and read the data to a data frame 

zip_URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zip_file <- "Assignment_Data/Dataset.zip"
download.file(zip_URL, zip_file)
full_dataset <- read.table(unzip(zip_file), header = TRUE, sep = ";", na.strings = "?")

## Merge the date and time variables and create a single POSIXct variable that represents both date and time

full_dataset <- mutate(full_dataset, date_and_time = paste(full_dataset$Date, full_dataset$Time))
full_dataset$date_and_time <- as.POSIXct(strptime(full_dataset$date_and_time, format = "%d/%m/%Y %H:%M:%S"))

## Change the "Date" column class to date and use this to subset the data for the specified 2-day period in Feb 2007 

full_dataset$Date <- as.Date(as.character(full_dataset$Date), format = "%d/%m/%Y")
subset_by_date <- na.omit(subset(full_dataset, Date == "2007-02-01" | Date == "2007-02-02"))

## Create a line graph for each type of Energy Sub Metering values over date and time and save it to a PNG file 

png(filename = "plot3.png")
plot(subset_by_date$date_and_time, subset_by_date$Sub_metering_1, 
     type = "l",
     xlab = "",
     ylab = "Energy sub metering",
     xaxt = "n")
lines(subset_by_date$date_and_time, subset_by_date$Sub_metering_2, col = "Red")
lines(subset_by_date$date_and_time, subset_by_date$Sub_metering_3, col = "Blue")
legend("topright", col = c("black", "Red", "Blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1,1))
r <- as.POSIXct(round(range(subset_by_date$date_and_time), "days"))
axis.POSIXct(1, at = seq(r[1], r[2], by = "day"), format = "%a")
dev.off()
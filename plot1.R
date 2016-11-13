## Check for data directory and create directory if it doesn't exist

if (!file.exists("Assignment_Data")) {
    dir.create("Assignment_Data")
}

## Download the data set, unzip the file and read the data to a data frame 

zip_URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zip_file <- "Assignment_Data/Dataset.zip"
download.file(zip_URL, zip_file)
full_dataset <- read.table(unzip(zip_file), header = TRUE, sep = ";", na.strings = "?")

## Change the "Date" column class to date and use this to subset the data for the specified 2-day period in Feb 2007 

full_dataset$Date <- as.Date(as.character(full_dataset$Date), format = "%d/%m/%Y")
subset_by_date <- na.omit(subset(full_dataset, Date == "2007-02-01" | Date == "2007-02-02"))

## Create a Histogram for the Global Active Power Data and save it to a PNG file  

png(filename = "plot1.png")
hist(subset_by_date$Global_active_power, 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     col = "Red")
dev.off()
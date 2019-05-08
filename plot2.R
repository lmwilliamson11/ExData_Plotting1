# Create data directory if it does not alread exist
if (!file.exists("data")) {
        dir.create("data")
}

zipfile<- "./data/household_power.zip"
data <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Download and unzip data if it has not already been downloaded
if (!file.exists(zipfile)) {
        download.file(data, destfile = zipfile, method = "curl")
        unzip(zipfile, exdir = "./data/")
}

#Read in lines from Feb 1 and Feb 2 2007
data_file <- "data/household_power_consumption.txt"
data_to_read <- grep("^1/2/2007|^2/2/2007", readLines(data_file))
skip <- data_to_read[1] - 1
nrows <- length(data_to_read)
plotting_data <- read.table(data_file, sep = ";", nrows = nrows, skip = skip)
colheaders <- readLines(data_file, n = 1)
colheaders <- unlist(strsplit(colheaders, ";"))
colnames(plotting_data) <- colheaders

# create a column with posixct date and times
date_time <- paste(plotting_data$Date, plotting_data$Time, sep = " ")
plotting_data$date_time <- as.POSIXct(strptime(date_time, "%d/%m/%Y %H:%M:%S"))

#create plot and save as png

png(filename = "plot2.png")
plot(plotting_data$date_time, plotting_data$Global_active_power, type = "l",
     main = "", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()

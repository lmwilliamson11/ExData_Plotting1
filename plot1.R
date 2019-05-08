
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

data_file <- "data/household_power_consumption.txt"
data_to_read <- grep("1/2/2007|2/2/2007", readLines(data_file))
skip <- data_to_read[1] - 1
nrows <- length(data_to_read)

plotting_data <- read.table(file = data_file, skip = skip, nrows = nrows, sep = ";")
colheaders <- readLines(data_file, n = 1)
colheaders <- unlist(strsplit(colheaders, ";"))
colnames(plotting_data) <- colheaders

png(filename = "plot1.png")
hist(plotting_data$Global_active_power, col = "red", xlab = "Global Active Powere (kilowatts)", main = "Global Active Power")
dev.off()


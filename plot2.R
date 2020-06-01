## plot2

## downloading the data
## uses package "downloader"
download("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", dest="dataset.zip", mode="wb") 
unzip ("dataset.zip", exdir = "./")

data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
subset <- data[(data$Date == '1/2/2007' | data$Date == '2/2/2007'), ]

## merging Date and Time columns into one 
datetime <- paste(subset$Date, subset$Time)
datetime2 <- dmy_hms(datetime)
subset2 <- cbind(subset, datetime2)

## modify class of Global_Active_Power
subset2$Global_active_power <- as.numeric(as.character(subset2$Global_active_power))

#creating the plot in a png file
png("plot2.png")
plot(subset2$datetime2, subset2$Global_active_power,xlab ="", ylab = "Global Active Power (kilowatts)", type = "l")
dev.off()
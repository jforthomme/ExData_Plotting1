## plot4

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

## modify classes
subset2$Global_active_power <- as.numeric(as.character(subset2$Global_active_power))
subset2$Global_reactive_power <- as.numeric(as.character(subset2$Global_reactive_power))
subset2$Sub_metering_1 <- as.numeric(as.character(subset2$Sub_metering_1))
subset2$Sub_metering_2 <- as.numeric(as.character(subset2$Sub_metering_2))
subset2$Sub_metering_3 <- as.numeric(as.character(subset2$Sub_metering_3))
subset2$Voltage <- as.numeric(as.character(subset2$Voltage))

#creating the plot in a png file
png("plot4.png")
par(mfrow = c(2, 2)) 
with(subset2, {
        plot(datetime2, Global_active_power, xlab ="", ylab = "Global Active Power", type = "l")
        plot(datetime2, Voltage, xlab ="datetime", ylab = "Voltage", type = "l")
        plot(subset2$datetime2, subset2$Sub_metering_1,xlab ="", ylab = "Energy sub metering", yaxt = 'n', type = "l")
        lines(subset2$datetime2, subset2$Sub_metering_2,xlab ="", col="red")
        lines(subset2$datetime2, subset2$Sub_metering_3,xlab ="", col="blue")
        axis(2, seq(0,30,10))
        legend("topright",pch = "_", col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty='n')
        plot(datetime2, Global_reactive_power, xlab ="datetime", type = "l")
})
dev.off()
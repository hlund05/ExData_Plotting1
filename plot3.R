temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp, method="curl")
power <- read.table(unz(temp, "household_power_consumption.txt"), sep=";")
unlink(temp)

subpower <- subset(power, V1 == "2/1/2007" | V1 == "2/2/2007")

subpower$V1 <- as.character(subpower$V1)
subpower$V2 <- as.character(subpower$V2)
subpower$datetime <- paste(subpower$V1, subpower$V2, sep=" ")

subpower <- transform(subpower, datetime = strptime(datetime, format="%m/%d/%Y %H:%M:%S"))
subpower <- transform(subpower, V7 = as.numeric(as.character(V7)))
subpower <- transform(subpower, V8 = as.numeric(as.character(V8)))
subpower <- transform(subpower, V9 = as.numeric(as.character(V9)))

library(datasets)
png(file="plot3.png", width=480, height=480)
plot(subpower$datetime, subpower$V7, ylab="Energy sub metering", xlab="", ylim=c(0,30), typ="l")
lines(subpower$datetime, subpower$V8, col="red")
lines(subpower$datetime, subpower$V9, col="blue")
legend("topright", lty=c(1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()



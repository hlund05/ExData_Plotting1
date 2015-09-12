temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp, method="curl")
power <- read.table(unz(temp, "household_power_consumption.txt"), sep=";")
unlink(temp)

subpower <- subset(power, V1 == "2/1/2007" | V1 == "2/2/2007")

subpower$V1 <- as.character(subpower$V1)
subpower$V2 <- as.character(subpower$V2)
subpower$datetime <- paste(subpower$V1, subpower$V2, sep=" ")

subpower <- transform(subpower, datetime = strptime(datetime, format="%m/%d/%Y %H:%M:%S"))
subpower <- transform(subpower, V3 = as.numeric(as.character(V3)))

library(datasets)
png(file="plot2.png", width=480, height=480)
plot(subpower$datetime, subpower$V3, ylab="Global Active Power (kilowatts)", xlab="", typ="l")
dev.off()
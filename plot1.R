temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp, method="curl")
power <- read.table(unz(temp, "household_power_consumption.txt"), sep=";")
unlink(temp)

subpower <- subset(power, V1 == "2/1/2007" | V1 == "2/2/2007")

subpower <- transform(subpower, V1 = as.Date(V1, "%m/%d/%Y"))
subpower <- transform(subpower, V3 = as.numeric(as.character(V3)))

library(datasets)
png(file="plot1.png", width=480, height=480)
hist(subpower$V3, breaks=10, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power", xlim=c(0,6))
dev.off()
library(sqldf)
library(lubridate)
library(dplyr)


df <- read.table("household_power_consumption.txt", na.strings="?", header=TRUE, sep=";", colClasses="character")
newdf <- mutate(df, Date=as.Date(dmy(Date)))

roi <- filter(newdf, Date == "2007-02-01" | Date == "2007-02-02" )  
#change column to numeric
roi$Global_active_power <- as.numeric(roi$Global_active_power)
hist(roi$Global_active_power, col="red", 
     main="Global Active Power", xlab="Global Active Power (kilowats)", 
     ylim=c(0,1200), xaxt="n", yaxt="n") 
axis(2, at=c(0,200,400,600,800,1000,1200), 
     col.axis="black", cex.axis=0.6)
axis(1, at=c(0,2,4,6), col.axis="black", cex.axis = 0.8)

# plot #2
#make x axis the Date + Time
roidt <- mutate(roi, dateTime = paste(roi$Date, roi$Time))
#change dateTime column to time
roidt$dateTime <- ymd_hms(roidt$dateTime)

maxy <- max(roidt$Global_active_power)
maxx <- max(roidt$dateTime)
xrange <- range(roidt$dateTime)
yrange <- range(roidt$Global_active_power)
plot(xrange, yrange, type="n", xlab="", ylab="Global Active Power (kilowats)")
lines(roidt$dateTime, roidt$Global_active_power)

# plot #3
yrange <- range(max(as.numeric(max(roidt$Sub_metering_1)), as.numeric(max(roidt$Sub_metering_2)), as.numeric(max(roidt$Sub_metering_3))))
yrange1 <- as.numeric(range(roidt$Sub_metering_1))
yrange2 <- as.numeric(range(roidt$Sub_metering_2))
yrange3 <- as.numeric(range(roidt$Sub_metering_3))

plot(xrange, yrange1, type="n", xlab="", ylab="Energy sub metering")
lines(roidt$dateTime, roidt$Sub_metering_1, col="black")
lines(roidt$dateTime, roidt$Sub_metering_2, col="red")
lines(roidt$dateTime, roidt$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1, cex=0.4, x.intersp=0.5)
# png("plot3.png", height = 480, width = 480, bg = "transparent")

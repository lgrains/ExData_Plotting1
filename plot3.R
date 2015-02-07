library(sqldf)
library(lubridate)
library(dplyr)

plot3 <- function(include) {
    
    readAndModData(include) 

    #make x axis the Date + Time
    roidt <- mutate(roi, dateTime = paste(roi$Date, roi$Time))
    #change dateTime column to time
    roidt$dateTime <- ymd_hms(roidt$dateTime)
    
    xrange <- range(roidt$dateTime)
    yrange1 <- as.numeric(range(roidt$Sub_metering_1))
    yrange2 <- as.numeric(range(roidt$Sub_metering_2))
    yrange3 <- as.numeric(range(roidt$Sub_metering_3))
    yrange <- range(0, max(yrange1, yrange2,yrange3))
    
    if (include) {
        png("plot3.png", width=480, height=480)
    
    }
    plot(xrange, yrange, type="n", xlab="", ylab="Energy sub metering")
    lines(roidt$dateTime, roidt$Sub_metering_1, col="black")
    lines(roidt$dateTime, roidt$Sub_metering_2, col="red")
    lines(roidt$dateTime, roidt$Sub_metering_3, col="blue")
    legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1, cex=0.8, x.intersp=0.5)
    
    if (include) {
        dev.off()
    }
}
library(sqldf)
library(lubridate)
library(dplyr)

plot4 <- function(include) {
    png("plot4.png", width=480, height=480)
    par(mfcol = c(2,2))
    
    readAndModData(include)
    
    #don't read the data again - it's already available
    plot2(!include)
    plot3(!include)
    
    #change column to numeric
    roi$Global_reactive_power <- as.numeric(roi$Global_reactive_power)
    
    #make x axis the Date + Time
    roidt <- mutate(roi, dateTime = paste(roi$Date, roi$Time))
    #change dateTime column to time
    roidt$dateTime <- ymd_hms(roidt$dateTime)
    
    # voltage
    xrange <- range(roidt$dateTime)
    yrange <- range(roidt$Voltage)
    plot(xrange, yrange, type="n", xlab="datetime", ylab="Voltage")
    lines(roidt$dateTime, roidt$Voltage)
    
    # Global_reactive_power
    xrange <- range(roidt$dateTime)
    yrange <- range(roidt$Global_reactive_power)
    plot(xrange, yrange, type="n", xlab="datetime", ylab="Global_reactive_power")
    lines(roidt$dateTime, roidt$Global_reactive_power)
    
    dev.off()
}
    

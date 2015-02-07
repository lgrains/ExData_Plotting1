library(sqldf)
library(lubridate)
library(dplyr)

plot2 <- function(include) {    
    readAndModData(include) 
    #change column to numeric
    roi$Global_active_power <- as.numeric(roi$Global_active_power)
    
    if (include) {
        png("plot2.png", width=480, height=480)
    }
    # plot #2
    #make x axis the Date + Time
    roidt <- mutate(roi, dateTime = paste(roi$Date, roi$Time))
    #change dateTime column to time
    roidt$dateTime <- ymd_hms(roidt$dateTime)

    xrange <- range(roidt$dateTime)
    yrange <- range(roidt$Global_active_power)
    plot(xrange, yrange, type="n", xlab="", ylab="Global Active Power (kilowats)")
    lines(roidt$dateTime, roidt$Global_active_power)
    if (include) {
        dev.off()
    }
}
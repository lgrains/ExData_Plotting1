library(sqldf)
library(lubridate)
library(dplyr)

plot1 <- function(include) {
    readAndModData(include)
    roi$Global_active_power <- as.numeric(roi$Global_active_power)
    
    png("plot1.png", width=480, height=480)
    hist(roi$Global_active_power, col="red", 
         main="Global Active Power", xlab="Global Active Power (kilowats)", 
         ylim=c(0,1200), xaxt="n", yaxt="n") 
    axis(2, at=c(0,200,400,600,800,1000,1200), 
         col.axis="black", cex.axis=0.6)
    axis(1, at=c(0,2,4,6), col.axis="black", cex.axis = 0.8)
    
    dev.off()
}

readAndModData <- function(include) {
    if (include) {
        dv <- read.csv.sql("household_power_consumption.txt", sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'", sep=";", colClasses="character")
        newdf <- mutate(df, Date=as.Date(dmy(Date)))
        roi <- filter(newdf, Date == "2007-02-01" | Date == "2007-02-02" )
    }    
}

readAndModDataWithTable <- function(include) {
    if (include) {
        df <- read.table("household_power_consumption.txt", na.strings="?", header=TRUE, sep=";", colClasses="character")
        newdf <- mutate(df, Date=as.Date(dmy(Date)))
        roi <- filter(newdf, Date == "2007-02-01" | Date == "2007-02-02" )
    }    
}


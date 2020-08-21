#BBBBugru

plot4 <- function() {
  power <- read.csv("./data/powercon/household_power_consumption.txt", 
                    sep = ";", 
                    na.strings = "?")
  
  ## change date to a format R will recognize
  power$Date <- as.Date(power$Date, format = "%d/%m/%Y")
  
  ## subset data to Feb 1 and 2, 2007
  powerSub <- subset(power, power$Date == "2007-02-01" | power$Date == "2007-02-02")
  
  ## make new column with date and time and convert to format R will recognize
  powerSub$DateTime <- paste(powerSub$Date, powerSub$Time)
  powerSub$DateTime <- as.POSIXct(powerSub$DateTime, format = "%Y-%m-%d %H:%M:%S")
  
  ## add day of week column
  powerSub$Day <- weekdays(powerSub$DateTime, abbreviate = TRUE)
  
  ## Plot #4
  ## establish a 2X2 panel for the 4-part plot
  par(mfrow = c(2, 2))
  
  ## 4A
  ## same plot as plot2.R
  with(powerSub, plot(DateTime, Global_active_power, type = "l", lty = 1, ylab = "Global Active Power (kilowatts)"))
  
  ## 4B
  ## plot voltage over time and label
  with(powerSub, plot(DateTime, Voltage, type = "l", lty = 1, ylab = "Voltage"))
  
  ## 4C
  ## same as plot3.R
  with(powerSub, plot(DateTime, Sub_metering_1, type = "l", ylab = "Energy sub metering"))
  with(powerSub, lines(DateTime, Sub_metering_2, type = "l", col = "red"))
  with(powerSub, lines(DateTime, Sub_metering_3, type = "l", col = "blue"))
  with(powerSub, legend("topright", 
                        legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
                        lty = c(1, 1, 1), 
                        col = c("black", "red", "blue")))
  
  ## 4D
  ## plot Grand_reactive_power over time
  with(powerSub, plot(DateTime, Global_reactive_power, type = "l", lty = 1, ylab = "Global Reactive Power"))
  
  ## Copy Plot # 4 to a png file
  dev.copy(png, file = "plot4.png", width = 480, height = 480, units = "px")
  
  ## deactivate device
  dev.off()
}

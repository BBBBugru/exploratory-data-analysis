#BBBBugru

plot3 <- function() {
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
  
  ## establish parameters - 1X1 panel
  par(mfrow = c(1, 1))
  
  ## make 1 plot with 3 different lines tracking Sub_metering over time, each line is a different color
  with(powerSub, plot(DateTime, 
                      Sub_metering_1, 
                      type = "l", 
                      ylab = "Energy sub metering"))
  with(powerSub, lines(DateTime, 
                       Sub_metering_2, 
                       type = "l", 
                       col = "red"))
  with(powerSub, lines(DateTime, 
                       Sub_metering_3, 
                       type = "l", 
                       col = "blue"))
  
  ## add a legend
  with(powerSub, legend("topright", 
                        legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
                        lty = c(1, 1, 1), 
                        col = c("black", "red", "blue")))

  ## copy to png file
  dev.copy(png, file = "plot3.png", width = 480, height = 480, units = "px")
  
  ## deactivate device
  dev.off()
}

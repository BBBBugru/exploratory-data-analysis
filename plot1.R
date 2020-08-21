#BBBBugru

plot1 <- function(){

  power <- read.csv("./data/powercon/household_power_consumption.txt", 
                    sep = ";", 
                    na.strings = "?")

  power$Date <- as.Date(power$Date, 
                    format = "%d/%m/%Y")

  ## subset data to Feb 1 and 2, 2007
  powerSub <- subset(power, 
                     power$Date == "2007-02-01" | power$Date == "2007-02-02")

  ## make new column with date and time and convert to format R will recognize
  powerSub$DateTime <- paste(powerSub$Date, powerSub$Time)
  powerSub$DateTime <- as.POSIXct(powerSub$DateTime, format = "%Y-%m-%d %H:%M:%S")

  ## add day of week column
  powerSub$Day <- weekdays(powerSub$DateTime, abbreviate = TRUE)

  ## Plot #1
  ## establish parameters - 1X1 panel
  par(mfrow = c(1, 1))

  ## make a histogram of the Global_active_power variable in red. Add appropriate labels
  hist(powerSub$Global_active_power, 
       col = "red", 
       main = "Global Active Power", 
       xlab = "Global Active Power (kilowatts)")

  ## copy the plot to a 480X480 png file
  dev.copy(png, file = "plot1.png", 
         width = 480, 
         height = 480, 
         units = "px")

  ## deactivate device 
  dev.off()
}

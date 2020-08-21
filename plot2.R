#BBBBugru

plot2 <- function() {

  power <- read.csv("./data/powercon/household_power_consumption.txt", sep = ";", na.strings = "?")

  ## change date to a format R will recognize
  power$Date <- as.Date(power$Date, format = "%d/%m/%Y")

  ## subset data to Feb 1 and 2, 2007
  powerSub <- subset(power, power$Date == "2007-02-01" | power$Date == "2007-02-02")

  ## make new column with date and time and convert to format R will recognize
  powerSub$DateTime <- paste(powerSub$Date, powerSub$Time)
  powerSub$DateTime <- as.POSIXct(powerSub$DateTime, format = "%Y-%m-%d %H:%M:%S")

  ## add day of week column
  powerSub$Day <- weekdays(powerSub$DateTime, abbreviate = TRUE)

  ## Plot #2
  ## establish parameters - 1X1 panel
  par(mfrow = c(1, 1))

  ## make a line plot looking at the Global_active_power variable over time and add a y-axis label
  with(powerSub, plot(DateTime, Global_active_power, type = "l", lty = 1, ylab = "Global Active Power (kilowatts)"))

  ## copy the plot to a png file
  dev.copy(png, file = "plot2.png", width = 480, height = 480, units = "px")

  ## deactivate device 
  dev.off()
}

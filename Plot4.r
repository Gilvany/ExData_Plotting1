library(rstudioapi); library(dplyr)

# Read the data from just those dates rather than reading in the entire dataset 
folder_path <- dirname(
  rstudioapi::getSourceEditorContext()$path)
file_path <- file.path(
  folder_path, "household_power_consumption.txt")

data.base <- read.table(
  file_path, 
  header = TRUE, 
  sep = ";", 
  stringsAsFactors = FALSE, 
  na.strings = "?"); head(data.base); 

data <- data.base

# convert the Date and Time variables to Date/Time classes in R using the 
data$Date <- as.Date(
  data$Date, 
  format = "%d/%m/%Y")
data$DateTime <- as.POSIXct(
  paste(data$Date, data$Time), 
  format = "%Y-%m-%d %H:%M:%S"); head(data)

# Examine how household energy usage varies over a 2-day period
# Subletting to those dates: data from the dates 2007-02-01 and 2007-02-02.
data <- data %>% filter(
  Date == as.Date("2007/02/01") | 
    Date == as.Date("2007/02/02")); head(data)

data.1 <- data

# Your task is to reconstruct the following plots below, all of which were 
# constructed using the base plotting system.

# Plot 4 ------------------------------------------------------------------
# PNG
png(file.path(folder_path, "plot4.png"), width=480, height=480)
## All in one <- 
par(mfrow = c(2, 2))

## Plot.4.1 <- 
plot(data.1$DateTime, data.1$Global_active_power, 
     type = "l", 
     col = "black",
     main = "Global Active Power", 
     xlab = "Time", 
     ylab = "Global Active Power (kilowatts)")

## Plot.4.2 <- 
plot(data.1$DateTime, data.1$Voltage, 
     type = "l", 
     col = "blue",
     xlab = "datetime", 
     ylab = "Voltage")

## Plot.4.3 <- 
plot(data.1$DateTime, data.1$Sub_metering_1, 
     type = "l", 
     col = "black",
     xlab = "", 
     ylab = "Energy sub metering"); lines(
       data.1$DateTime,
       data.1$Sub_metering_2, 
       col = "red"); lines(
         data.1$DateTime, 
         data.1$Sub_metering_3, 
         col = "blue"); legend(
           "topright", 
           col = c("black", "red", "blue"), 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           lty = 1)

## Plot.4.4 <- 
barplot(data.1$Global_reactive_power, 
        names.arg = format(data.1$DateTime, "%H:%M"), 
        col = "red", 
        main = "Global Reactive Power", 
        xlab = "Time", 
        ylab = "Global Reactive Power (kilowatts)")

dev.off()

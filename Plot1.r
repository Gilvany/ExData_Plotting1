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

# Plot 1 ------------------------------------------------------------------
# PNG
png(file.path(folder_path, "plot1.png"), width=480, height=480)
## Plot.1 <- 
hist(
  data.1$Global_active_power, 
  names.arg = format(data.1$DateTime, "%H:%M"),  # Format DateTime for better x-axis labeling
  col = "red", 
  main = "Global Active Power", 
  xlab = "Time", ylab = "Global Active Power (kilowatts)"); colnames(data.1)

dev.off()


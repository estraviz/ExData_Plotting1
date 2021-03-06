##########################################################################
## Exploratory Data Analysis Course project 1: plot 4                    #
## Name: Javier Estraviz                                                 #
## Date: February, 2015                                                  #
##########################################################################

# We'll be using the Individual household electric power consumption Data 
# Set from the UC Irvine Machine Learning Repository.

##########################################################################

# Libraries used
library("sqldf")

# Set up the working directory to the location of the current file
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)

# Download and unzip the file that will be used in the project  
# Create directory where the data of the project will be allocated
if(!file.exists("./data")) {
  dir.create("data")
}

# Download the zip file with the dataset for the project. Unzip this file
setwd("./data")

# Download file if it doesn't exist yet in the data directory
if(!file.exists("./household_power_consumption.txt")) {
  fileURL <- paste("https://d396qusza40orc.cloudfront.net/", 
                   "exdata%2Fdata%2Fhousehold_power_consumption.zip", sep="")
  download.file(fileURL, destfile = "household_power_consumption.zip", 
                method = "curl") 
  unzip("household_power_consumption.zip")
}

# Load the data for predetermined dates 2007/02/01 and 2007/02/02
mydata <- read.csv.sql(file="household_power_consumption.txt",
                       header=TRUE,sep=";",
                       sql="SELECT *
                       FROM file 
                       WHERE Date = '1/2/2007' 
                       OR Date = '2/2/2007'")

# Let's depict the required histogram for Global Active Power
# We'll create the graphics in the same location that the .R files
setwd(this.dir)

# I have to change by code the LC_TIME locale category into English to be sure
# that the names of weekdays appear in English. 
Sys.setlocale("LC_TIME", "C") ## at least for Mac OS X, this works

png(filename="plot4.png",width=480,height=480)

# We calculate datetime, used in this case in the four graphics
datetime <- strptime(paste(mydata$Date,mydata$Time,sep=" "),"%d/%m/%Y %H:%M:%S")

# We represent the 4 graphics in 2 rows and 2 columns
par(mfrow=c(2,2))

# First one is the depicted in plot2.R (note: no "kilowatts" in ylab)
with(mydata, plot(x=datetime,
                  y=Global_active_power,
                  type="l",
                  col="black",
                  xlab="",
                  ylab="Global Active Power"))

# Second one 
with(mydata, plot(x=datetime,
                  y=Voltage,
                  type="l",
                  col="black",
                  ylab="Voltage"))

# Third one is the depicted in plot3.R, with the legend without a boundary
with(mydata, plot(x=datetime,
                  y=Sub_metering_1,
                  type="l",
                  col="black",
                  xlab="",
                  ylab="Energy sub metering"))
with(mydata, lines(x=datetime,
                   y=Sub_metering_2,
                   col="red"))
with(mydata, lines(x=datetime,
                   y=Sub_metering_3,
                   col="blue"))
legend("topright",
       bty="n",
       lty=c(1,1),
       col=c("black","red","blue"),
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Finally, fourth one 
with(mydata, plot(x=datetime,
                  y=Global_reactive_power,
                  type="l"))

# We finally shut down the png graphics device    
dev.off()
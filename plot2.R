##########################################################################
## Exploratory Data Analysis Course project 1: plot 2                    #
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

png(filename="plot2.png",width=480,height=480)
datetime <- strptime(paste(mydata$Date,mydata$Time,sep=" "),"%d/%m/%Y %H:%M:%S")
with(mydata, plot(x=datetime,
                  y=Global_active_power,
                  type="l",
                  col="black",
                  xlab="",
                  ylab="Global Active Power (kilowatts)"))

# We finally shut down the png graphics device    
dev.off()

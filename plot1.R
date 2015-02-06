##########################################################################
## Exploratory Data Analysis Course project 1: plot 1                    #
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

# Get URL with the file inside 80 columns as R Style Guide recommends (e.g. 
# Google's: https://google-styleguide.googlecode.com/svn/trunk/Rguide.xml)
fileURL <- paste("https://d396qusza40orc.cloudfront.net/", 
                 "exdata%2Fdata%2Fhousehold_power_consumption.zip", sep="")
download.file(fileURL, destfile = "household_power_consumption.zip", 
              method = "curl") 
unzip("household_power_consumption.zip")

# Load the data for predetermined dates 2007/02/01 and 2007/02/02
setwd(this.dir)
setwd("./data/")
mydata <- read.csv.sql(file="household_power_consumption.txt",
                       header=TRUE,sep=";",
                       sql="SELECT *
                            FROM file 
                            WHERE Date = '1/2/2007' 
                               OR Date = '2/2/2007'")

# Let's depict the required histogram for Global Active Power
# We'll create the graphics in the same location that the .R files
setwd(this.dir)
png(filename="plot1.png",width=480,height=480)
with(mydata, hist(Global_active_power,
                  col="red",
                  xlab="Global Active Power (kilowatts)",
                  ylab="Frequency",
                  main="Global Active Power"))

# We finally shut down the png graphics device    
dev.off()

getwd()
setwd("C:\\Users\\charles\\Desktop\\couseras")
setwd("C:\\Users\\charles\\Desktop\\couseras\\course2")

# Creating Folder and Downloading Datasets in the folder:
if(!file.exists("data")) dir.create("data")
fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip?accessType=DOWNLOAD"
download.file(fileurl, destfile = "./data/NEI_data.zip", mode="wb")
unzip("./data/NEI_data.zip", exdir = "./data/NEI.rds")
#Reading the Files_
NEI<-readRDS("./data/NEI.rds/summarySCC_PM25.rds")
SCC<-readRDS("./data/NEI.rds/Source_Classification_Code.rds")
#Checking if Files exist in the Directory:
dir()
#findata <- with(NEI, aggregate(Emissions, by = list(year), sum))
#findata
#View(NEI)
#View(SCC)

#length(NEI$Emissions)
#length(NEI$year)
#Calculating Total per year
tot.PM25yr <- aggregate(Emissions ~ year,NEI, sum)

#tot.PM25yr

#prepare to plot to png
png("plot1.png",width=480,height=480)

barplot (tot.PM25yr$Emissions,
         names.arg=tot.PM25yr$year,
         xlab="Year",
         ylab="PM2.5 Emissions",
         main="Total PM2.5 Emissions in the United States from 1999-2007")

dev.off() 
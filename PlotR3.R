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
#dir()

#View(NEI)
#View(SCC)

#length(NEI$Emissions)
#length(NEI$year)

#Subsetting NEI (fips=24510) and summing emiision per Type and year
SubNEI=subset(NEI,fips=="24510")
SubNEI
Stot.PM25yr  <- aggregate(SubNEI[c("Emissions")], list(type = SubNEI$type, year = SubNEI$year), sum)
#Stot.PM25yr

###prepare to plot to png
library(ggplot2)
png("plot3.png")
qplot(year, Emissions, data = Stot.PM25yr, color = type, geom= "line")+ggtitle("Total PM2.5 Emissions in Baltimore City by Source Type")+xlab("Year") + ylab("PM2.5 Emissions")
dev.off()  
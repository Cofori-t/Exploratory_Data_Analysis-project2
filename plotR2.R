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
#Subsetting NEI (fips=24510) and summing emiision per year
SubNEI=subset(NEI,fips=="24510")
Stot.PM25yr <- aggregate(Emissions ~ year,SubNEI, sum)
#tot.PM25yr

###Step 2: prepare to plot to png
png("plot2.png",width=480,height=480)

barplot (Stot.PM25yr$Emissions,
         names.arg=Stot.PM25yr$year,
         xlab="Year",
         ylab="PM2.5 Emissions",
         main="Total PM2.5 Emissionsin Baltimore city")

dev.off()         
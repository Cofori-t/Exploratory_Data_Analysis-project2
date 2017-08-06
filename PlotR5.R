getwd()
setwd("C:\\Users\\charles\\Desktop\\couseras")
setwd("C:\\Users\\charles\\Desktop\\couseras\\course2")

# Creating Folder and Downloading Datasets in the folder:
if(!file.exists("data")) dir.create("data")
fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip?accessType=DOWNLOAD"
download.file(fileurl, destfile = "./data/NEI_data.zip", mode="wb")
unzip("./data/NEI_data.zip", exdir = "./data/NEI.rds")
#Reading the Files
NEI<-readRDS("./data/NEI.rds/summarySCC_PM25.rds")
SCC<-readRDS("./data/NEI.rds/Source_Classification_Code.rds")
#View(SCC)

# Subsetting vehicle (fips=24510) dataset and preparing for Plot
veh <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehSCC <- SCC[veh,]$SCC
vehNEI <- NEI[NEI$SCC %in% vehSCC,]
SubVehNEI <- vehNEI[vehNEI$fips=="24510",]
#View(SubVehNEI)
#Plotting emmisions from motor Vehicle source changed fro 1999-2008
library(ggplot2)
png("plot5.png")
ggplot(SubVehNEI,aes(factor(year),Emissions/10^6))+geom_bar(stat="identity",fill="grey",width=0.75)+theme_bw() +  guides(fill=FALSE)+  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^6 Tons)"))+labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))
dev.off()


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

# Subset coal combustion related NEI data
coal <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
comb <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
#coal
#comb
#combine coal/combution and prepare data for plot
coalComb<- (comb & coal)
combSCC <- SCC[coalComb,]$SCC
combNEI <- NEI[NEI$SCC %in% combSCC,]

#Plotting data
library(ggplot2)
png("plot4.png")
ggplot(combNEI,aes(factor(year),Emissions/10^6))+geom_bar(stat="identity",fill="grey",width=0.75)+theme_bw() +  guides(fill=FALSE)+  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^6 Tons)"))+labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))
dev.off()


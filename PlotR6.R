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
# Subsetting Baltimore city (fips=24510) and LA county (fips=06037) dataset from NEI
veh <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehSCC <- SCC[veh,]$SCC
vehNEI <- NEI[NEI$SCC %in% vehSCC,]

vehBaltNEI <- vehNEI[vehNEI$fips=="24510",]

#View(SubVehNEI)

vehLANEI <- vehNEI[vehNEI$fips=="06037",]
vehBaltNEI$city <- "Baltimore City"
vehLANEI$city <- "Los Angeles County"

# Combine the two subsets with city name into one data frame
combNEI <- rbind(vehBaltNEI,vehLANEI)
#Preparing to plot to compare emmision from motor vehicle source in Baltimore city and LA County
library(ggplot2)
png("plot6.png")
ggplot(combNEI, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +  facet_grid(scales="free", space="free", .~city) +
  guides(fill=FALSE) + theme_bw() +  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore - Los Angels, 1999-2008"))

dev.off()


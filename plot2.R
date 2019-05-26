## read the ddata
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## open a png graphics device
png(filename="plot2.png")

## subset data from Baltimore City
sub <- subset(NEI, fips=="24510" & year%in%c(1999, 2008))
sum <- tapply(sub$Emissions, sub$year, sum)

barplot(sum, main="The Total PM2.5 Emissions in Boltimore", 
	xlab="Year", ylab="Emissions",
	col=topo.colors(2)
)

## close the graphics device
dev.off()
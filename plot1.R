## read the ddata
NEI <- readRDS("summarySCC_PM25.rds")

## open a png graphics device
png(filename="plot1.png")

sum <- tapply(NEI$Emissions, NEI$year, sum)

barplot(sum,
	main="The Total PM2.5 Emissions", 
	xlab="Year", ylab="Emissions",
	col=topo.colors(4)
)

## close the graphics device
dev.off()
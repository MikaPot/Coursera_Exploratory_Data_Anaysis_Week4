## load ggplot2 package
library(ggplot2)
library(dplyr)

## read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## subset the data from Baltimore city and from 1999-2008
## tha data is highly left skewed to add 1 to each variable
## and take log formation
sub <- NEI %>% filter(fips=="24510", year%in%c(1999, 2008)) %>%
	mutate(Emissions=log10(Emissions+1))

## make a plot
ggplot(sub, aes(x=factor(year), y=Emissions)) +
	geom_boxplot(aes(col=type)) +
	facet_grid(.~type) +
	labs(title="The PM2.5 Emissions in Boltimore",
		x="year", y="Emissions")

## save the plot
ggsave("plot3.png")
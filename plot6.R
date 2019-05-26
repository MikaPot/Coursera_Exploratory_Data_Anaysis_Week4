## load ggplot2 package
library(ggplot2)
library(dplyr)

## read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## subset the data in Baltimorea and LA from 1999-2008
## tha data is highly left skewed to add 1 to each variable
## and take log formation
sub <- NEI %>% filter(fips%in%c("24510","06037"), year%in%c(1999, 2008)) %>%
	mutate(Emissions=log10(Emissions+1)) %>%
	mutate(fips=ifelse(fips=="24510", "Boltimore", "LA"))

## subset the data from coal combustion-related sources
## I'm going to use a category "EI.Sector" which has
## a form like "Fuel Comb - Electric Generation - Coal"
coal_com <- SCC %>% filter(regexpr("Mobile", EI.Sector) != -1) %>%
	 pull(SCC) %>% as.character

## make a plot
sub %>% filter(SCC %in% coal_com) %>%
	ggplot(aes(x=factor(year), y=Emissions)) +
	geom_boxplot(aes(color=factor(year))) +
	facet_grid(col=vars(factor(fips)))
	labs(title="The PM2.5 Emissions from Motor vehicles in Boltimore",
		x="year", y="Emissions")

## save the plot
ggsave(filename="plot6.png")

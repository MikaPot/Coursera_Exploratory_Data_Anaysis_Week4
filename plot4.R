## load ggplot2 package
library(ggplot2)
library(dplyr)

## read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## subset the data from 1999-2008
## tha data is highly left skewed to add 1 to each variable
## and take log formation
sub <- NEI %>% filter(year%in%c(1999, 2008)) %>%
	mutate(Emissions=log10(Emissions+1))

## subset the data from coal combustion-related sources
## I'm going to use a category "EI.Sector" which has
## a form like "Fuel Comb - Electric Generation - Coal"
coal_com <- SCC %>% filter(regexpr("Comb(.*)Oil", EI.Sector) != -1) %>%
	 pull(SCC)

## make a plot
ggplot(sub, aes(x=factor(year), y=Emissions)) +
	geom_bosplot(aes(color=factor(year)) +
	labs(title="The PM2.5 Emissions from Coal Combustion",
		x="year", y="Emissions")

## save the plot
ggsave("plot4.png")
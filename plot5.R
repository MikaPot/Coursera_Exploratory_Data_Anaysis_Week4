## load ggplot2 package
library(ggplot2)
library(dplyr)

## read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## subset the data in Baltimore city from 1999-2008
## tha data is highly left skewed to add 1 to each variable
## and take log formation
sub <- NEI %>% filter(fips=="24510", year%in%c(1999, 2008)) %>%
	mutate(Emissions=log10(Emissions+1))

## subset the data from motor vehicles sources
## I'm going to use a category "EI.Sector" 
motor <- SCC %>% filter(regexpr("Mobile", EI.Sector) != -1) %>%
	 pull(SCC) %>% as.character

## make a plot
sub %>% filter(SCC %in% motor) %>%
	ggplot(aes(x=factor(year), y=Emissions)) +
	geom_boxplot(aes(color=factor(year))) +
	labs(title="The PM2.5 Emissions from Motor vehicles in Boltimore",
		x="year", y="Emissions")

## save the plot
ggsave("plot5.png")
library(dplyr)
library(ggplot2)

######################
##  Load data set
NEI <- readRDS("summarySCC_PM25.rds")

## Data subset
NEI <- tbl_df(NEI)
NEI <- NEI %>% filter(fips == "24510") %>% select(Emissions, year, type)

# Total emissions
NEI <- NEI %>% group_by(year, type) %>% summarize(Emissions = sum(Emissions))

## Faceted barplot
ggplot(NEI, aes(factor(year), Emissions)) +
    geom_bar(stat = "identity") +
    facet_grid(type ~ .) +     
    ggtitle("Fine Particle Emissions (Baltimore City, 1999 to 2008)") + 
    xlab("Year") + 
    ylab(expression('PM'[2.5]*' emitted, in tons'))


### Obsolete -> boxplot version
## Faceted boxplot
#ggplot(NEI, aes(factor(year), Emissions)) +
    #geom_boxplot() +
    #facet_grid(type ~ .) +     
    #ggtitle("Fine Particle Emissions (Baltimore City, 1999 to 2008)") + 
    #xlab("Year") + 
    #ylab(expression('PM'[2.5]*' emitted, in tons')) +
    #coord_cartesian(ylim = c(0, 11))
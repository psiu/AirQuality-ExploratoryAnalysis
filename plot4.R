library(dplyr)
library(ggplot2)

######################
##  Load data set
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Data subset
SCC <- tbl_df(SCC)
SCC <- SCC %>% filter(SCC.Level.Three == "Bituminous/Subbituminous Coal") %>% select(SCC)

# Inner join to subset only coal combustion sources
NEI <- merge(SCC, NEI)

NEI <- tbl_df(NEI)
NEI <- NEI %>% select(Emissions, year)

## Plot
ggplot(NEI, aes(factor(year), Emissions)) +
    geom_boxplot() +
    ggtitle("Fine Particle Emissions (Coal Combustion, 1999 to 2008)") + 
    xlab("Year") + 
    ylab(expression('PM'[2.5]*' emitted, in tons')) +
    coord_cartesian(ylim = c(0, 6))

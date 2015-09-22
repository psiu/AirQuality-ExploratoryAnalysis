library(dplyr)
library(ggplot2)


######################
##  Load data set
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Data subset
SCC <- tbl_df(SCC)
SCC <- SCC %>% filter(EI.Sector == "Mobile - On-Road Diesel Heavy Duty Vechicles" | EI.Sector == "Mobile - On-Road Diesel Light Duty Vehicles" | EI.Sector == "Mobile - On-Road Heavy Duty Vehicles" | EI.Sector == "Mobile - On-Road Gasoline Light Duty Vehicles") %>% select(SCC)

# Inner join to subset only motor vehicles
NEI <- merge(SCC, NEI)

NEI <- tbl_df(NEI)
# Subset Baltimore City and Los Angeles
NEI <- NEI %>% filter(fips == "24510" | fips == "06037") %>% select(Emissions, year, fips)
NEI <- mutate(NEI, city = ifelse(fips == "24510", "Baltimore City", "Los Angeles"))

## Plot
ggplot(NEI, aes(factor(year), Emissions)) +
    geom_boxplot() +
    ggtitle("Motor Vehicle Fine Particle Emissions (Baltimore City vs Los Angeles, 1999 to 2008)") + 
    xlab("Year") + 
    ylab(expression('PM'[2.5]*' emitted, in tons')) +
    facet_grid(city ~ .) +   
    coord_cartesian(ylim = c(0, 17))
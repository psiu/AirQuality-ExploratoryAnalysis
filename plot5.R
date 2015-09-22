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
NEI <- NEI %>% filter(fips == "24510") %>% select(Emissions, year)

## Plot
ggplot(NEI, aes(factor(year), Emissions)) +
    geom_boxplot() +
    ggtitle("Fine Particle Emissions (Motor Vehicles in Baltimore City, 1999 to 2008)") + 
    xlab("Year") + 
    ylab(expression('PM'[2.5]*' emitted, in tons')) +
    coord_cartesian(ylim = c(0, 1.75))

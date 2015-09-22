library(dplyr)

######################
##  Load data set
NEI <- readRDS("summarySCC_PM25.rds")


## Data subset
NEI <- tbl_df(NEI)
NEI <- NEI %>% filter(fips == "24510") %>% select(Emissions, year)

## Base plot
boxplot(Emissions ~ year, NEI, xlab = "Year", ylab = expression('PM'[2.5]*' emitted, in tons'), main = "Fine Particle Emissions (Baltimore City, 1999 to 2008)", ylim = c(0,2.2))

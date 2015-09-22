library(dplyr)

######################
##  Load data set
NEI <- readRDS("summarySCC_PM25.rds")


## Memory optimization, reducing data set to essential columns
NEI <- tbl_df(NEI)
NEI <- select(NEI, Emissions, year)

## Base plot
boxplot(Emissions ~ year, NEI, xlab = "Year", ylab = expression('PM'[2.5]*' emitted, in tons'), main = "Fine Particle Emissions (USA, 1999 to 2008)", ylim = c(0,.25))

library(dplyr)

######################
##  Load data set
NEI <- readRDS("summarySCC_PM25.rds")


## Memory optimization, reducing data set to essential columns
NEI <- tbl_df(NEI)
NEI <- select(NEI, Emissions, year)

# Total emissions
NEI <- NEI %>% group_by(year) %>% summarize(Emissions = sum(Emissions))

## Base plot
barplot(NEI$Emissions, names = NEI$year,xlab = "Year", ylab = expression('PM'[2.5]*' emitted, in tons'), main = "Fine Particle Emissions (USA, 1999 to 2008)")



## Obsolete -> only if calculating with boxplot
#boxplot(Emissions ~ year, NEI, xlab = "Year", ylab = expression('PM'[2.5]*' emitted, in tons'), main = "Fine Particle Emissions (USA, 1999 to 2008)", ylim = c(0,.25))
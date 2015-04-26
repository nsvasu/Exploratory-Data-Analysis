rm(list=ls())

library(ggplot2)
library(reshape2)

#loading the datasets
NEI <- readRDS("exdata-data-NEI_data\\summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data\\Source_Classification_Code.rds")

#Baltimore (fips ="24510") dataset
df <- NEI[NEI$fips == "24510", ]

# Melt & cast
bMelt <- melt(df, id = c("year", "type"), measure.vars = c("Emissions"))
bCast <- dcast(bMelt, year + type ~ variable, sum)
bCast$type <- as.factor(bCast$type)

colnames(bCast) <- c("Year", "Type","Emissions")

#creating the plot
g <- ggplot(bCast, aes(x = Year, y = Emissions, color = Type))
g + geom_line() + labs(title = expression('Total PM' [2.5] * ' Emissions Per Year in Baltimore by Type of Emission'))


#creating and saving the png file
dev.copy(png, file = "plot3.png", 
		width = 500, 
		height = 480, 
		units = "px")

dev.off()

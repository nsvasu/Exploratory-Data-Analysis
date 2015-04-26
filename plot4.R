rm(list=ls())

#loading the datasets
NEI <- readRDS("exdata-data-NEI_data\\summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data\\Source_Classification_Code.rds")

#Finding coal related SCC
coalSCCs <- SCC[grep("Coal", SCC$Short.Name), 1]

#Filtering the data
coalNEI <- NEI[NEI$SCC %in% coalSCCs, ]

#Aggregates
df <- aggregate(coalNEI$Emissions ~ coalNEI$year, FUN = sum)

#renaming the column names
colnames(df) <- c("Year", "Emissions")

#creating the bar graph
barplot(df$Emissions, main = expression('Total PM' [2.5] * ' Emissions Per Year From Coal'), 
	names.arg = c("1999", "2002", "2005", "2008"), 
	xlab = "Year", 
	ylab = expression('Total PM' [2.5] * ' Emissions'))

#creating and saving the png file
dev.copy(png, file = "plot4.png", 
		width = 480, 
		height = 480, 
		units = "px")

dev.off()

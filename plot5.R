rm(list=ls())

#loading the datasets
NEI <- readRDS("exdata-data-NEI_data\\summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data\\Source_Classification_Code.rds")

#Finding motor related SCC
motorSCCs <- SCC[grep("Locomotives|Vehicles", SCC$Short.Name), 1]

#Filtering the data
balNEI <- NEI[NEI$fips == "24510", ]
motorNEI <- NEI[balNEI$SCC %in% motorSCCs, ]

#Aggregates
df <- aggregate(motorNEI$Emissions ~ motorNEI$year, FUN = sum)

#renaming the column names
colnames(df) <- c("Year", "Emissions")

#creating the bar graph
barplot(df$Emissions, main = expression('Total PM' [2.5] * ' Emissions from Baltimore Motor related Per Year' ), 
	names.arg = c("1999", "2002", "2005", "2008"), 
	xlab = "Year", 
	ylab = expression('Total PM' [2.5] * ' Emissions'))

#creating and saving the png file
dev.copy(png, file = "plot5.png", 
		width = 480, 
		height = 480, 
		units = "px")

dev.off()

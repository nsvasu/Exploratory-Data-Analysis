rm(list=ls())

library(ggplot2)

#loading the datasets
NEI <- readRDS("exdata-data-NEI_data\\summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data\\Source_Classification_Code.rds")

#Finding motor related SCC
motorSCCs <- SCC[grep("Locomotives|Vehicles", SCC$Short.Name), 1]

#Filtering the data
balNEI <- NEI[NEI$fips == "24510", ]
laNEI <- NEI[NEI$fips == "06037", ]

balNEI <- balNEI[balNEI$SCC %in% motorSCCs, ]
laNEI <- laNEI[laNEI$SCC %in% motorSCCs, ]

#Aggregates
bal.df <- aggregate(balNEI$Emissions ~ balNEI$year, FUN = sum)
la.df <- aggregate(laNEI$Emissions ~ laNEI$year, FUN = sum)

#renaming the column names
colnames(bal.df) <- c("Year", "Emissions")
colnames(la.df) <- c("Year", "Emissions")

# Adding the location 
bal.df$Location <- "Baltimore" 
la.df$Location <- "Los Angeles" 


df <- rbind(bal.df, la.df)

#creating the bar graph
g <- ggplot(df, aes(x = Year, y = Emissions, color = Location)) 
g + geom_line() + labs(title = expression('Total PM' [2.5] * ' Emissions from Motor Vehicles Per Year by Location')) 

#creating and saving the png file
dev.copy(png, file = "plot6.png", 
		width = 480, 
		height = 480, 
		units = "px")

dev.off()

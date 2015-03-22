# Loads gpplot2 library
library(ggplot2)

# Loads RDS [ Assumption: Data file summarySCC_PM25.rds is available under ./data]
NEI <- readRDS("data/summarySCC_PM25.rds")
NEI$year <- factor(NEI$year, levels = c('1999', '2002', '2005', '2008'))
SCC <- readRDS("data/Source_Classification_Code.rds")

# Filter and get data for Baltimore City, Maryland
MD.onroad <- subset(NEI, fips == '24510' & type == 'ON-ROAD')
# Filter and get data for Los Angeles County, California
CA.onroad <- subset(NEI, fips == '06037' & type == 'ON-ROAD')

# Aggregates total Emission by Year for both cities
MD.DF <- aggregate(MD.onroad[, 'Emissions'], by = list(MD.onroad$year), sum)
colnames(MD.DF) <- c('year', 'Emissions')
MD.DF$City <- paste(rep('Baltimore, MD', 4))

CA.DF <- aggregate(CA.onroad[, 'Emissions'], by = list(CA.onroad$year), sum)
colnames(CA.DF) <- c('year', 'Emissions')
CA.DF$City <- paste(rep('Los Angeles, CA', 4))

# Combine data for both cities into single data frame.
DF <- as.data.frame(rbind(MD.DF, CA.DF))

#Bar Chart
#png('plot6_Bar.png')
#ggplot(data = DF, aes(x = year, y = Emissions)) + geom_bar(aes(fill = year),stat = "identity") + guides(fill = F) + ggtitle('Total Emissions of Motor Vehicle Sources\nLos Angeles County, California vs. Baltimore City, Maryland') + ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position = 'none') + facet_grid(. ~ City) + geom_text(aes(label = round(Emissions, 0), size = 1, hjust = 0.5, vjust = -1))
#dev.off()
#Line Chart
png('plot6.png')
ggplot(data = DF, aes(x = year, y = Emissions, colour = as.factor(DF$City), group = as.factor(DF$City))) + geom_line() + ggtitle('Total Emissions of Motor Vehicle Sources\nLos Angeles County, California vs. Baltimore City, Maryland') + ylab(expression('PM'[2.5])) + xlab('Year') + scale_colour_discrete(name  ="City", breaks=c("Baltimore, MD", "Los Angeles, CA"), labels=c("Baltimore, MD", "Los Angeles, CA"))

dev.off()
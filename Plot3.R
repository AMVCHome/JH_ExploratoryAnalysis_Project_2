# Loads gpplot2 library
require(ggplot2)

# Loads RDS [ Assumption: Data file summarySCC_PM25.rds is available under ./data]
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# Samples data for testing
NEIsample <- NEI[sample(nrow(NEI), size = 5000, replace = F), ]

# Filter data for Baltimore City, Maryland == fips
MD <- subset(NEI, fips == 24510)
MD$year <- factor(MD$year, levels = c('1999', '2002', '2005', '2008'))

#Plot
png('plot3.png', width = 800, height = 500, units = 'px')
ggplot(data = MD, aes(x = year, y = log(Emissions))) + facet_grid(. ~ type) + guides(fill = F) + geom_boxplot(aes(fill = type)) + stat_boxplot(geom = 'errorbar') + ylab(expression(paste('Log', ' of PM'[2.5], ' Emissions'))) + xlab('Year') + ggtitle('Emissions per Type in Baltimore City, Maryland') + geom_jitter(alpha = 0.10)
dev.off()
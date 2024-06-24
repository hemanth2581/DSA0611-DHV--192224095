# Install required libraries (if not already installed)
if(!require(ggplot2)) install.packages("ggplot2", dependencies=TRUE)
if(!require(vcd)) install.packages("vcd", dependencies=TRUE)

# Load required libraries
library(ggplot2)
library(vcd)

# Creating the dataset
data <- data.frame(
  Year = c(2019, 2020, 2022, 2023, 2024),
  Job_Sector = c("IT", "Government Job", "Customer care", "Bank", "Games"),
  Job_Seekers_Rate = c(95, 97, 98, 82, 74),
  Selection_Rate = c(25, 12, 45, 20, 35)
)

# 1. Pie Plot for Job Seekers' Data
pie_data <- data$Job_Seekers_Rate
names(pie_data) <- data$Job_Sector

# Plotting the Pie Plot
pie(pie_data, main="Pie Plot of Job Seekers Rate by Job Sector", col=rainbow(length(pie_data)))

# 2. Mosaic Plot for the Given Dataset
mosaic_data <- xtabs(~Job_Sector + Year, data)

# Plotting the Mosaic Plot
mosaic(mosaic_data, shade=TRUE, legend=TRUE, main="Mosaic Plot of Job Sectors by Year")

# 3. Funnel Plot for Selection Rate
funnel_data <- data.frame(
  Job_Sector = data$Job_Sector,
  Job_Seekers_Rate = data$Job_Seekers_Rate,
  Selection_Rate = data$Selection_Rate
)

# Plotting the Funnel Plot
ggplot(funnel_data, aes(x=Job_Sector, y=Selection_Rate)) +
  geom_point(aes(size=Job_Seekers_Rate), color='blue', alpha=0.6) +
  geom_text(aes(label=Job_Sector), vjust=-1) +
  scale_size_continuous(range = c(3, 15)) +
  labs(title="Funnel Plot of Selection Rate by Job Sector", x="Job Sector", y="Selection Rate") +
  theme_minimal()
# Load necessary libraries
library(ggplot2)
library(reshape2)

# Create the dataset
data <- data.frame(
  Date = as.Date(c("2024-01-01", "2024-01-02", "2024-01-03", "2024-01-04", "2024-01-05", "2024-01-06")),
  Station_A_Temperature = c(25.0, 24.5, 26.2, 23.8, 25.5, 23.0),
  Station_A_Precipitation = c(0.1, 0.0, 0.3, 0.2, 0.1, 0.4),
  Station_B_Temperature = c(23.5, 22.8, 25.0, 22.5, 24.5, 21.8),
  Station_B_Precipitation = c(0.2, 0.3, 0.1, 0.0, 0.4, 0.2)
)

# Display the dataset
print(data)
# Melt the data for ggplot
data_melt <- melt(data, id.vars = "Date")

# Create time series plot
ggplot(data_melt, aes(x = Date, y = value, color = variable)) +
  geom_line() +
  labs(title = "Time Series Plot of Temperature and Precipitation",
       x = "Date",
       y = "Value",
       color = "Variable") +
  theme_minimal()
# Create a separate line plot for temperatures
ggplot(data, aes(x = Date)) +
  geom_line(aes(y = Station_A_Temperature, color = "Station A Temperature")) +
  geom_line(aes(y = Station_B_Temperature, color = "Station B Temperature")) +
  labs(title = "Line Plot of Temperature by Date",
       x = "Date",
       y = "Temperature (°C)",
       color = "Legend") +
  theme_minimal()
# Melt the data for stacked bar plot
data_long <- melt(data, id.vars = "Date", 
                  measure.vars = c("Station_A_Temperature", "Station_A_Precipitation", "Station_B_Temperature", "Station_B_Precipitation"),
                  variable.name = "Station_Variable", value.name = "Value")

# Create the stacked bar plot
ggplot(data_long, aes(x = Date, y = Value, fill = Station_Variable)) +
  geom_bar(stat = "identity") +
  labs(title = "Stacked Bar Plot of Temperature and Precipitation by Date",
       x = "Date",
       y = "Value",
       fill = "Legend") +
  theme_minimal()
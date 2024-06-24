# Load necessary libraries
library(ggplot2)
library(ggmosaic)
library(dplyr)

# Create the dataset
data <- data.frame(
  Year = c(2019, 2020, 2022, 2023, 2024),
  Browser = rep('Chrome', 5),
  Users = c(22.7, 25.8, 28.7, 30.5, 35.2)
)

# 1. Pie Plot
pie_chart <- function(data) {
  data <- data %>%
    mutate(fraction = Users / sum(Users)) %>%
    mutate(percentage = paste0(round(fraction * 100, 1), "%"))
  
  ggplot(data, aes(x = "", y = fraction, fill = factor(Year))) +
    geom_bar(stat = "identity", width = 1) +
    coord_polar(theta = "y") +
    theme_void() +
    geom_text(aes(label = percentage), position = position_stack(vjust = 0.5)) +
    labs(title = "Internet Users by Year (Using Chrome)", fill = "Year") +
    scale_fill_brewer(palette = "Set3")
}

# 2. Mosaic Plot
mosaic_plot <- function(data) {
  ggplot(data) +
    geom_mosaic(aes(x = product(Year, Browser), fill = Browser), na.rm = TRUE) +
    labs(title = "Mosaic Plot of Internet Users by Year and Browser",
         x = "Year",
         y = "Browser") +
    scale_fill_brewer(palette = "Set3") +
    theme_minimal()
}

# 3. Scatter Plot
scatter_plot <- function(data) {
  ggplot(data, aes(x = Year, y = Users, color = Browser)) +
    geom_point(size = 4) +
    labs(title = "Scatter Plot of Internet Users by Year (Using Chrome)",
         x = "Year",
         y = "Users (in Millions)") +
    scale_color_brewer(palette = "Set3") +
    theme_minimal()
}

# Plotting the charts
pie_chart(data)
mosaic_plot(data)
scatter_plot(data)
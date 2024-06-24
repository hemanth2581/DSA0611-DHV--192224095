# Create the dataset
data <- data.frame(
  Month = c("Jan", "Feb", "March", "April", "May", "Jun", "July", "August", "Sep", "Oct", "Nov", "Dec"),
  Economic_Condition = c("Good", "Good", "Good", "Good", "Fair", "Fair", "Good", "Bad", "Fair", "Good", "Bad", "Fair"),
  Unemployment_Rate = c(10.7, 9.8, 10.2, 11.2, 15.75, 17.8, 19.4, 25.6, 18.6, 15.6, 26.7, 19.5)
)

# Calculate aggregated data
agg_data <- aggregate(Unemployment_Rate ~ Economic_Condition, data, sum)

# Stacked Bar Plot
barplot(agg_data$Unemployment_Rate, names.arg = agg_data$Economic_Condition,
        col = rainbow(length(agg_data$Economic_Condition)),
        main = "Stacked Bar Plot of Unemployment Rate by Economic Condition",
        ylab = "Unemployment Rate (%)",
        xlab = "Economic Condition")

# Pie Plot
pie(agg_data$Unemployment_Rate, labels = paste(agg_data$Economic_Condition, round(agg_data$Unemployment_Rate/sum(agg_data$Unemployment_Rate)*100, 1), "%"),
    col = rainbow(length(agg_data$Economic_Condition)),
    main = "Pie Plot of Unemployment Rate by Economic Condition")

# Prepare data for Grouped Bar Plot
data$Month <- factor(data$Month, levels = c("Jan", "Feb", "March", "April", "May", "Jun", "July", "August", "Sep", "Oct", "Nov", "Dec"))
data_sorted <- data[order(data$Month), ]
economic_conditions <- unique(data_sorted$Economic_Condition)
data_matrix <- matrix(0, nrow = length(unique(data_sorted$Month)), ncol = length(economic_conditions),
                      dimnames = list(levels(data_sorted$Month), economic_conditions))

for (i in 1:nrow(data_sorted)) {
  data_matrix[as.character(data_sorted$Month[i]), data_sorted$Economic_Condition[i]] <- data_sorted$Unemployment_Rate[i]
}

# Grouped Bar Plot
barplot(t(data_matrix), beside = TRUE,
        col = rainbow(length(economic_conditions)),
        main = "Grouped Bar Plot of Unemployment Rate by Month and Economic Condition",
        ylab = "Unemployment Rate (%)",
        xlab = "Month",
        legend = colnames(data_matrix),
        args.legend = list(x = "topright", inset = 0.05))
library(tidyverse)

# Read data
surveys <- read_rds(file = "data/usa_2021_23.rds")

# Plot 1: Income by Education and Gender
inc_distrib_plot <- surveys |>
  ggplot(aes(x = educ_level, y = exp(log_income), fill = gender)) +  # Transform back
  geom_boxplot() +
  facet_wrap(~ lep, 
             labeller = labeller(lep = c(`1` = "Limited English", `0` = "English Proficient"))) +
  scale_y_continuous(labels = scales::dollar_format()) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        strip.text = element_text(face = "bold")) +
  labs(
    title = "Income Distribution by Education Level, LEP Status, and Gender",
    x = "Education Level",
    y = "Income (USD)",
    fill = "Gender"
  )

ggsave("plots/inc_distrib_plot.png", inc_distrib_plot) # Save plot as an image

# Plot 2: Education distribution by LEP status
edu_distrib_plot <- surveys |>
  count(lep, educ_level) |>
  group_by(lep) |>
  mutate(prop = n / sum(n) * 100) |>
  ggplot(aes(x = educ_level, y = prop, fill = factor(lep))) +  # Add factor() here
  geom_col(position = "dodge") +
  scale_y_continuous(labels = scales::percent_format(scale = 1)) +
  scale_fill_discrete(name = "LEP Status", 
                     labels = c("English Proficient", "Limited English")) +
  labs(y = "Percentage (%)",
       x = "Education Level",
       title = "Education Distribution by LEP Status") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave("plots/edu_distrib_plot.png", edu_distrib_plot) # Save plot as an image

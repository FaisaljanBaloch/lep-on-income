library(tidyverse)

# Read data
x <- read_rds(file = "data/usa_2021_23.rds") |>
  mutate(
    educ_level = factor(
      educ_level,
      levels = c(
        "Less than HS",
        "High school",
        "Some college",
        "Bachelor's",
        "Graduate"
      )
    ) # Order education levels
  )

# Save refined data
saveRDS(x, file = "data/usa_2021_23.rds")

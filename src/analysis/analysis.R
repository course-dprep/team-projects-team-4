# analysis.R
# Visual checks + linear models for m_runtime, genre, and m_runtime×genre moderation
# Outputs a PDF report to ../../gen/output/

library(readr)
library(tidyverse)
library(ggplot2)
library(broom)

# 1) Read filtered data from gen/temp
IMDB_filtered <- read_csv("../../gen/temp/imdb_filtered.csv")

# 2) Convert top_genre to a factor for regression
IMDB_filtered$top_genre <- as.factor(IMDB_filtered$top_genre)

# 3) Create output directory
dir.create("../../gen/output", showWarnings = FALSE, recursive = TRUE)

# 4) Linear models

# Model 1: Mean-centered Runtime + top_genre (main effects only)
lm_main <- lm(averageRating ~ m_runtime + top_genre, data = IMDB_filtered)
summary(lm_main)
saveRDS(lm_main, "../../gen/output/lm_main.rds")

# Model 2: Mean-centered Runtime × top_genre (main effects + interaction)
lm_interaction <- lm(averageRating ~ m_runtime * top_genre, data = IMDB_filtered)
summary(lm_interaction)
saveRDS(lm_interaction, "../../gen/output/lm_interaction.rds")

#5 Plots and tables
# Model comparison -
anova_result <- anova(lm_main, lm_interaction)
saveRDS(anova_result, "../../gen/output/anova_result.rds")

# Comparison table (suggested by course chatbot)
model_comparison <- broom::glance(lm_main) %>%
  bind_rows(broom::glance(lm_interaction)) %>%
  mutate(model = c("main", "interaction"))
write_csv(model_comparison, "../../gen/output/model_comparison.csv")

# Compact table of mean-centered runtime + mean-centered runtime×genre terms from lm_interaction
interaction_terms <- tidy(lm_interaction, conf.int = TRUE) %>%
  filter(term == "m_runtime" | str_detect(term, "^m_runtime:top_genre")) %>%
  arrange(desc(abs(estimate)))
saveRDS(interaction_terms, "../../gen/output/interaction_terms.rds")

# Interaction plot (by genre)
interaction_plot <- ggplot(IMDB_filtered, aes(x = runtimeMinutes, y = averageRating)) +
  geom_point(alpha = 0.15, size = 0.8) +
  geom_smooth(method = "lm", se = TRUE, color = "steelblue") +
  facet_wrap(~ top_genre, scales = "fixed") +
  labs(
    title = "Runtime vs. Average Rating by Genre",
    x = "Runtime (minutes)",
    y = "Average Rating"
  ) +
  theme_minimal()

ggsave("../../gen/output/interaction_plot.png", interaction_plot, width = 10, height = 7)


# Overall descriptive statistics
overall_stats <- IMDB_filtered %>%
  summarise(
    n = n(),
    mean_rating = round(mean(averageRating, na.rm = TRUE), 2),
    median_rating = round(median(averageRating, na.rm = TRUE), 2),
    sd_rating = round(sd(averageRating, na.rm = TRUE), 2),
    mean_runtime = round(mean(runtimeMinutes, na.rm = TRUE), 1),
    median_runtime = round(median(runtimeMinutes, na.rm = TRUE), 1),
    sd_runtime = round(sd(runtimeMinutes, na.rm = TRUE), 1),
    n_genres = n_distinct(top_genre)
  )
write_csv(overall_stats, "../../gen/output/overall_stats.csv")

# Descriptive statistics table by genre
descriptive_stats <- IMDB_filtered %>%
  group_by(top_genre) %>%
  summarise(
    n = n(),
    mean_rating = round(mean(averageRating, na.rm = TRUE), 2),
    median_rating = round(median(averageRating, na.rm = TRUE), 2),
    sd_rating = round(sd(averageRating, na.rm = TRUE), 2),
    mean_runtime = round(mean(runtimeMinutes, na.rm = TRUE), 1),
    median_runtime = round(median(runtimeMinutes, na.rm = TRUE), 1),
    sd_runtime = round(sd(runtimeMinutes, na.rm = TRUE), 1)
  ) %>%
  arrange(desc(n))

write_csv(descriptive_stats, "../../gen/output/descriptive_stats.csv")

#Movie Count by Genre
movie_count <- IMDB_filtered %>%
  count(top_genre) %>%
  ggplot(aes(x = reorder(top_genre, n), y = n)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(title = "Movie Count by Genre")
ggsave("../../gen/output/movie_count.png", movie_count, width = 10, height = 7)

#IMDB ratings by genre
ratings_by_genre <- ggplot(IMDB_filtered, aes(x = top_genre, y = averageRating)) +
  geom_boxplot() +
  coord_flip() +
  labs(title = "IMDb Ratings by Genre")
ggsave("../../gen/output/ratings_by_genre.png", ratings_by_genre, width = 10, height = 7)

#read descriptive stats table
read_csv("../../gen/output/descriptive_stats.csv")

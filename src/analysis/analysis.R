# analysis.R
# Visual checks + linear models for runtime, genre, and runtime×genre moderation
# Outputs a PDF report to ../../gen/output/

library(readr)
library(tidyverse)
library(ggplot2)
library(broom)

# -----------------------------------------
# 1) Read filtered data from gen/temp
# -----------------------------------------
IMDB_filtered <- read_csv("../../gen/temp/imdb_filtered.csv")

# Convert top_genre to a factor for regression
IMDB_filtered$top_genre <- as.factor(IMDB_filtered$top_genre)

# -----------------------------------------
# 2) Create output directory & open PDF
# -----------------------------------------
dir.create("../../gen/output", showWarnings = FALSE, recursive = TRUE)
pdf("../../gen/output/analysis_report.pdf", width = 10, height = 7)

# -----------------------------------------
# 3) Create mean-centered runtime variable
# -----------------------------------------
IMDB_filtered <- IMDB_filtered %>%
  mutate(m_runtime = runtimeMinutes - mean(runtimeMinutes, na.rm = TRUE))

# -------------------------
# 4) GGPlot diagnostics
# -------------------------

# (A) Overall linearity: scatter + linear fit
ggplot(IMDB_filtered, aes(x = runtimeMinutes, y = averageRating)) +
  geom_point(alpha = 0.05) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    x = "Runtime (minutes)",
    y = "Average rating",
    title = "Runtime vs Average Rating (Linear Fit)"
  )

# (B) By-genre linearity
ggplot(IMDB_filtered, aes(x = runtimeMinutes, y = averageRating, color = top_genre)) +
  geom_point(alpha = 0.03) +
  geom_smooth(method = "lm", se = FALSE) +
  facet_wrap(~ top_genre) +
  labs(
    x = "Runtime (minutes)",
    y = "Average rating",
    title = "Runtime vs Average Rating by Top Genre"
  )

# -------------------------
# 5) Linear models
# -------------------------

# Model 1: Runtime only
lm1 <- lm(averageRating ~ m_runtime, data = IMDB_filtered)
summary(lm1)

# Model 2: Runtime + top_genre (main effects only)
lm2 <- lm(averageRating ~ m_runtime + top_genre, data = IMDB_filtered)
summary(lm2)

# Model 3: Runtime × top_genre (main effects + interaction)
lm3 <- lm(averageRating ~ m_runtime * top_genre, data = IMDB_filtered)
summary(lm3)

# Model comparison - ANOVA as text on PDF page
anova_result <- anova(lm1, lm2, lm3)
plot.new()
title(main = "ANOVA: Model Comparison", cex.main = 1.5)
text(0.05, 0.85, paste(capture.output(anova_result), collapse = "\n"),
     family = "mono", adj = c(0, 1), cex = 0.7)

# Compact table of runtime + runtime×genre terms from lm3
interaction_terms <- tidy(lm3, conf.int = TRUE) %>%
  filter(term == "m_runtime" | str_detect(term, "^m_runtime:top_genre")) %>%
  arrange(desc(abs(estimate)))

plot.new()
title(main = "Runtime x Top Genre Interaction Terms (Model 3)", cex.main = 1.3)
text(0.05, 0.85, paste(capture.output(print(interaction_terms, n = Inf)), collapse = "\n"),
     family = "mono", adj = c(0, 1), cex = 0.5)

# -----------------------------------------
# Close PDF device
# -----------------------------------------
dev.off()

cat("Report saved to: ../../gen/output/analysis_report.pdf\n")

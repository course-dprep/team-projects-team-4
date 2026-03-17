# In this directory, you will keep all source code files relevant for 
# preparing/cleaning your data.

# Load libraries
library(readr)
library(tidyverse)

# Read data

title.basics  <- read_tsv("../../data/raw/title.basics.tsv.gz", na = "\\N")
title.ratings <- read_tsv("../../data/raw/title.ratings.tsv.gz", na = "\\N")

# Overview of titleTypes
# 
# title.basics %>%
#   group_by(titleType) %>%
#   summarise(count = n()) %>%
#   arrange(desc(count))

# Select movies only
title.basics_movies <- filter(title.basics, titleType == "movie")

# Merging the title.basics and title.ratings datasets

  IMDB_movies <- left_join(title.basics_movies, title.ratings, by = "tconst")

# Remove NA's from genres, runtimeMinutes, averageRating and numVotes
# and drop titleType, isAdult, startYear and endYear

IMDB_movies <- IMDB_movies %>%
  filter(!is.na(genres),
         runtimeMinutes <= 360,
         !is.na(averageRating),
         numVotes > 100) %>%
  select(-titleType, -isAdult, -startYear, -endYear)

# Step 1: Split genres into individual rows for counting
genre_split <- IMDB_movies %>%
  select(tconst, genres) %>%
  separate_rows(genres, sep = ",")

# Step 2: Identify the top 10 most frequent genres
top10_genres <- genre_split %>%
  count(genres, sort = TRUE) %>%
  slice_head(n = 10) %>%
  pull(genres)

cat("Top 10 genres:\n")
print(top10_genres)

# Step 3 & 4: For each movie, count how many of its genres are in the top 10.
#              Keep only movies where exactly 1 genre is in the top 10.
IMDB_filtered <- IMDB_movies %>%
  mutate(
    top_genres_list = map(str_split(genres, ","), ~ intersect(.x, top10_genres)),
    n_top = map_int(top_genres_list, length)
  ) %>%
  filter(n_top == 1)

cat("Movies with exactly 1 top-10 genre:", nrow(IMDB_filtered), "\n")

# Step 5: Create the top_genre column and clean up helper columns
IMDB_filtered <- IMDB_filtered %>%
  mutate(top_genre = map_chr(top_genres_list, 1)) %>%
  select(-top_genres_list, -n_top)

# Write filtered dataset
write_csv(IMDB_filtered, "../../gen/temp/imdb_filtered.csv")


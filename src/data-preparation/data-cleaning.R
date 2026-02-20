# In this directory, you will keep all source code files relevant for 
# preparing/cleaning your data.

# Load libraries
library(readr)
library(tidyverse)


# Read data

title.basics <-  read_tsv("data/raw/title.basics.tsv.gz")
title.ratings <- read_tsv("data/raw/title.ratings.tsv.gz")

# Overview of titleTypes

title.basics %>%
  group_by(titleType) %>%
  summarise(count = n()) %>%
  arrange(desc(count))

# Select Movies Only
title.basics_movies <- filter(title.basics, titleType == "movie")

# Merging the title.basics and title.ratings datasets

IMDB_movies <- left_join(title.basics_movies, title.ratings, by = "tconst")

# Splitting genres
IMDB_movies <- IMDB_movies %>% 
  separate_rows(genres, sep = ",") %>% 
  mutate(value = 1) %>% 
  pivot_wider(names_from = genres,
              values_from = value,
              values_fill = 0,
              names_prefix = "genre_")

# List of genres

names(IMDB_movies)[grepl("genre", names(IMDB_movies))]

# Are the variables isAdult and genre_Adult identical?
identical(IMDB_movies$isAdult, IMDB_movies$genre_Adult)


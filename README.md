
# Does movie length matter? The relationship between film length and audience score between genres.

The goal of this project is to examine the relationship between movie running time and audience ratings, 
and how this relationship may differ between a selection of movie genres. 


## Motivation

The movie industry continuously tries to understand what factors influence audience ratings, as they play an important role in determining commercial success and popularity. One characteristic that might impact viewers’ perceptions is running time. Longer films can allow for more extensive storytelling and character development; however, they may also demand higher mental effort and time commitment from the audience. As a consequence, the relationship between running time and audience ratings remains unclear and worth investigating.

Previous research in media and entertainment studies suggests that structural movie characteristics can influence audience evaluations and satisfaction (Cini & Abela, 2025).

Furthermore, audience expectations may differ between movie genres. For instance, viewers might expect longer runtimes in genres such as drama, whereas faster-paced runtimes may be expected in low cognitive effort genres such as comedies. Genre-based expectation theories propose that consumers develop category-specific expectations that influence their evaluations (Jeffres, Atkin, & Neuendorf, 2023).

In addition, theories related to cognitive load and information processing suggest that increased exposure time may influence judgments due to differences in mental effort.

<br>

**Based on these notions, the main research question that will be examined is described as:**

*- What is the relationship between running time (IV) and audience ratings (DV) in movies, and how does this differ between movie genres?*

## Data
To examine the research question, two publicly available datasets from the IMDB website
were utilized and later merged.

The data sets used:  
- https://datasets.imdbws.com/title.basics.tsv.gz  
- https://datasets.imdbws.com/title.ratings.tsv.gz  

<br>

After merging, the final dataset contains approximately 140.000 observations after filtering for movies, their running time (<=360 minutes) and number of votes (>100),
where missing values for genre's and audience ratings were filtered out.

<br>

- Include a table of variable description/operationalisation.


The main variables that will be examined:

• Movie running time (IV) - primary runtime of the title, in minutes  
• Audience rating (DV) - weighted average of all the individual user ratings  
• Genre (Categorical Moderator) - includes up to three genres associated with the title  
  

## Method

For data preparation, data wrangling principles were administered. Firstly the dataset title.basics.tsv.gz 
was filtered to only include movie titles, thereby excluding other included film-types in the dataset such 
as tv-shows and short-films. Next, the dataset title.ratings.tsv.gz was merged.
This merged dataset was structured in ascending order of release year.  

Moreover, next to filtering for missing values for genre and audience scores, the observations were filtered to
have a running time of up to 360 minutes and a minimum number of 100 recorded audience votes.

<br>

As for the method of analysis, Multiple Linear Regression (MLR) with interaction terms will be used. 
MLR is an appropriate analysis method for a continuous IV and DV, allowing examination of interaction
terms for movie genre as a moderator.



## Repository Overview 
```text
genre-runtime-effect/
│
├── data/                    # Data-related scripts and raw data handling
│   └── placeholder.txt      # Placeholder until data is downloaded
│
├── reporting/               # Final report and application files
│   ├── report.Rmd           # Main analysis report
│   └── start_app.R          # Option to run the report using a Shiny app
│
├── src/                     # Source code
│   ├── analysis/            # Statistical modeling and analysis scripts
│   │   └── analysis.R       # Main analysis script
│   │
│   └── data-preparation/    # Data cleaning and preparation scripts
│       └── data-cleaning.R  # Data cleaning script
│
├── README.md                # Project documentation
├── makefile                 # Workflow automation
├── .gitignore               # Files excluded from version control
└── genre-runtime-effect.Rproj  # RStudio project file
```
## Preview of Findings

The analysis reveals that movie runtime has a small but significant positive effect on audience ratings overall.  Longer movies tend to get a slightly higher rating. However, the relationship differs based on genres.For example, Thriller films benefit the most from longer runtimes, compared to Comedy or Adventure films that tend to receive lower ratings as runtime increases. Drama and Horror films show no significant interaction with runtime.

The findings are deployed as a reproducible HTML report generated with RMarkdown, which includes regression tables, visualizations of interaction effects, and clear interpretations of the results.

These findings are relevant for filmmakers, editors, and streaming platforms, as they suggest that the runtime for a movie is not universal but depends heavily on genre. Understanding these can help professionals take informed decisions regarding their productions.

## Dependencies 

To recreate and run this repository's workflow, a recent version of R Studio is necessary.

The main packages needed to run this workflow in R Studio:

- R Package: readr - used to read selected datasets  
- R Package: tidyverse - used for data wrangling and analysis  

To load these packages in R:

```text
# Load libraries
library(readr)
library(tidyverse)

In addition, **Pandoc** is required to render the RMarkdown report to HTML. Pandoc can be downloaded from:

- **Windows (recommended version 3.9.0.2)**: https://github.com/jgm/pandoc/releases/tag/3.9.0.2

```


## Running Instructions 

*Provide step-by-step instructions that have to be followed to run this workflow.*

To run this repository's workflow, you first need to clone the GitHub repository.

#### Step 1: Cloning this repository
Using Command Prompt on Windows/ Terminal on Mac, clone this repository:

```text
git clone https://github.com/course-dprep/genre-runtime-effect.git

```
After cloning the repository, the necessary folders will be copied to your pc/laptop.  

#### Step 2: Downloading the data files

Next, after opening the data folder, you will run into an R script file named "download-data.R".
The first lines of code will allow you to create a new folder to store the raw datasets, followed by code
to then download the datasets:

```text

# Create raw data folder
dir.create("data/raw", showWarnings = FALSE, recursive = TRUE)

# Download data files

download.file("https://datasets.imdbws.com/title.basics.tsv.gz","data/raw/title.basics.tsv.gz")

download.file("https://datasets.imdbws.com/title.ratings.tsv.gz","data/raw/title.ratings.tsv.gz")


```
#### Step 3: loading packages, reading datafiles
Finally, the appropriate packages need to be loaded and the datafiles need to be read in R Studio.

```text

# Load libraries
library(readr)
library(tidyverse)


# Read data

title.basics  <- read_tsv("data/raw/title.basics.tsv.gz", na = "\\N")
title.ratings <- read_tsv("data/raw/title.ratings.tsv.gz", na = "\\N")

```

After following these three steps, any interested people should be able
to recreate, or further analyse the IMDB datasets appropriately.


## About 

This project is set up as part of the Master's course [Data Preparation & Workflow Management](https://dprep.hannesdatta.com/) at the [Department of Marketing](https://www.tilburguniversity.edu/about/schools/economics-and-management/organization/departments/marketing), [Tilburg University](https://www.tilburguniversity.edu/), the Netherlands.

The project is implemented by Team 4, members: Dalyl Lachkar, Ahmad Meirghadam, Francesca Stoica, Youri Vandenbussche, Wanja Koekman

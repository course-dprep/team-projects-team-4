[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/-5U7Jn2O)
> **Important:** This is a template repository to help you set up your team project.  
>  
> You are free to modify it based on your needs. For example, if your data is downloaded using *multiple* scripts instead of a single one (as shown in `\data\`), structure the code accordingly. The same applies to all other starter files—adapt or remove them as needed.  
>  
> Feel free to delete this text.


# Title of your Project: The role of film length and audience scores
(Describe the purpose of this project)

The goal of this project is to examine the relationship between movie running time and audience ratings, 
and how this relationship may differ between movie genres. 



## Motivation
(Provide background/motivation for your project)
(Mention your research question)

The movie industry continuously tries to understand what factors influence audience ratings, as they play a
very important role in determining commercial success and popularity. One characteristic that might impact
viewer’s perceptions is running time. Longer films can allow for more extensive storytelling and character
development, however they may also demand higher mental effort and time commitment from the audience.
As a consequence, the relationship between running time and audience ratings remains unclear and worth
looking into.
Secondly, audience expectations on time might differ between movie genres. For instance, viewers might
expect longer runtimes in genres like drama, considering the complexity of the storyline, whereas fast paced
runtimes might be expected for low cognitive effort genres, such as comedies. Considering this, the effect of
runtime on ratings in most likely not uniform, and it might depend on viewing preferences.

Based on this, the main research question that will be examined is described as:

What is the relationship between running time (IV) and audience ratings (DV) in movies, and
how does this differ between movie genres?


*Provide background/motivation for your project*

**Mention your research question**

## Data

- What dataset(s) did you use? How was it obtained?
To examine the research question, two publicly available datasets from the IMBD website
were utilized.

The data sets used:
- https://datasets.imdbws.com/title.basics.tsv.gz
- https://datasets.imdbws.com/title.ratings.tsv.gz


- How many observations are there in the final dataset?

...

- Include a table of variable description/operstionalisation. 

The main variables that will be examined:

• Movie running time (IV) - primary runtime of the title, in minutes
• Audience rating (DV) - weighted average of all the individual user ratings
• Genre (Categorical Moderator) - includes up to three genres associated with the title
• Title type (control variable) - the type/format of the title (e.g. movie, short, tvseries, tvepisode, video, etc)


## Method

- What methods do you use to answer your research question?

Multiple Linear Regression (MLR)

- Provide justification for why it is the most suitable. 

MLR is an appropriate method for a continuous IV and DV, with genres as a moderator.


## Preview of Findings 
- Describe the gist of your findings (save the details for the final paper!)
...

- How are the findings/end product of the project deployed?
...

- Explain the relevance of these findings/product. 
...

## Repository Overview 

**Include a tree diagram that illustrates the repository structure*

## Dependencies 

*Explain any tools or packages that need to be installed to run this workflow.*

For now:

library(readr)
library(tidyverse)

## Running Instructions 

*Provide step-by-step instructions that have to be followed to run this workflow.*

...

## About 

This project is set up as part of the Master's course [Data Preparation & Workflow Management](https://dprep.hannesdatta.com/) at the [Department of Marketing](https://www.tilburguniversity.edu/about/schools/economics-and-management/organization/departments/marketing), [Tilburg University](https://www.tilburguniversity.edu/), the Netherlands.

The project is implemented by team < x > members: < insert member details>

OUTPUT = ../gen/output

all: report.pdf

report.pdf: report.Rmd $(OUTPUT)/lm_main.rds $(OUTPUT)/lm_interaction.rds $(OUTPUT)/anova_result.rds $(OUTPUT)/interaction_terms.rds $(OUTPUT)/model_comparison.csv $(OUTPUT)/interaction_plot.png $(OUTPUT)/descriptive_stats.csv $(OUTPUT)/movie_count.png $(OUTPUT)/ratings_by_genre.png
	Rscript -e "rmarkdown::render('report.Rmd')"

clean:
	R -e "unlink('../gen', recursive = TRUE)"
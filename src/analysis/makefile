# Variables
TEMP = ../../gen/temp
OUTPUT = ../../gen/output

# Targets
all: $(OUTPUT)/lm_main.rds $(OUTPUT)/lm_interaction.rds $(OUTPUT)/anova_result.rds $(OUTPUT)/interaction_terms.rds $(OUTPUT)/model_comparison.csv $(OUTPUT)/interaction_plot.png $(OUTPUT)/descriptive_stats.csv

# Analysis
$(OUTPUT)/lm_main.rds $(OUTPUT)/lm_interaction.rds $(OUTPUT)/anova_result.rds $(OUTPUT)/interaction_terms.rds $(OUTPUT)/model_comparison.csv $(OUTPUT)/interaction_plot.png $(OUTPUT)/descriptive_stats.csv $(OUTPUT)/overall_stats.csv: analysis.R $(TEMP)/imdb_filtered.csv
	Rscript analysis.R

clean:
	R -e "unlink('../../gen', recursive = TRUE)"
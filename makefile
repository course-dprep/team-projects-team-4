# This makefile will be used to automate the
# different steps in your project.

all: data-preparation analysis

data-preparation:
	$(MAKE) -C src/data-preparation

analysis: data-preparation
	$(MAKE) -C src/analysis


clean:
		R -e "unlink('data', recursive = TRUE)"
		R -e "unlink('gen', recursive = TRUE)"
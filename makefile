all: data-preparation analysis report

data-preparation:
	$(MAKE) -C src/data-preparation

analysis: data-preparation
	$(MAKE) -C src/analysis

report: analysis
	$(MAKE) -C reporting

clean:
	R -e "unlink('data', recursive = TRUE)"
	R -e "unlink('gen', recursive = TRUE)"
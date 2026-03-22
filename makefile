all: data-preparation analysis report

data-preparation:
	make -C src/data-preparation

analysis: data-preparation
	make -C src/analysis

report: analysis
	make -C reporting

clean:
	R -e "unlink('data', recursive = TRUE)"
	R -e "unlink('gen', recursive = TRUE)"
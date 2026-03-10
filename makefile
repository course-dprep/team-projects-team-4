# This makefile will be used to automate the
# different steps in your project.


#This is only a draft, not fully operational yet but should work when the analysis makefile is created.

all: analysis data-preparation

data-preparation:
		make -C src/data-preparation

analysis: data-preparation
		make -C src/analysis


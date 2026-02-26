.PHONY: build pdfs htmls md clean
.DEFAULT_GOAL := build

TYPST_COMPILE := typst compile --format pdf
TYPST_EXPORT  := typst compile --features html --format html
PANDOC        := pandoc

SOURCES := $(wildcard *.typ)
PDFS    := $(SOURCES:.typ=.pdf)
HTMLS   := $(SOURCES:.typ=.html)
MDS     := $(HTMLS:.html=.md)

$(SOURCES): lib/components.typ

build: $(PDFS) $(HTMLS) $(MDS)
pdfs: $(PDFS)
htmls: $(HTMLS)
md: $(MDS)

%.pdf: %.typ
	$(TYPST_COMPILE) $<

%.html: %.typ
	$(TYPST_EXPORT) $<

%.md: %.html
	$(PANDOC) -f html -t gfm -o $@ $<

clean:
	rm -f $(PDFS) $(HTMLS) $(MDS)


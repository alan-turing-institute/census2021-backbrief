report.pdf : report.md
	pandoc --filter pandoc-citeproc --filter pandoc-crossref --bibliography=Census2021-Backbrief.bib --toc -o $@ $<

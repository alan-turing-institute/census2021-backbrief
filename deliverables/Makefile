report.pdf : report.md
	pandoc --toc-depth 2 --filter pandoc-crossref --filter pandoc-citeproc --bibliography=Census2021-Backbrief.bib --toc -o $@ $<

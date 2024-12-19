texengine=pdflatex
main.pdf : *.tex *.bib
	${texengine}  --shell-escape -interaction nonstopmode main

all: *.tex
	${texengine}  --shell-escape -interaction nonstopmode -halt-on-error -file-line-error main
	bibtex main
	${texengine}  --shell-escape -interaction nonstopmode -halt-on-error -file-line-error main
	${texengine}  --shell-escape -interaction nonstopmode -halt-on-error -file-line-error main

full: clean all

clean:
	${RM} -rf *.aux *.log *.blg *.ent  tmp/* *.auxlock *.bbl *.out *.md5 *.glo *.acn *.fls
	${RM} -rf *.mtc* *.idx *.ilg *.ind *.ist *.loe *.lof *.maf *.bcf *.toc *.run.xml
	${RM} -rf main.pdf

pull:
	git stash; git pull --rebase; git stash pop; make

push:
	git commit -am "Pushed using make push"; git pull --rebase; git push origin master

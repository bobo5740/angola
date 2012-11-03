.SUFFIXES: .tex

LATEX=latex
PDFLATEX=pdflatex
BIBTEX=bibtex


All: projekt ps

projekt:
		@echo Compiling report...
		@latex  samlet #> /dev/null
		@bibtex samlet #> /dev/null
		@latex  samlet #> /dev/null
		@latex  samlet #> /dev/null
# !note not using defined compiler to reduce output

ps:
		@echo Creating PS file
		@dvips -o samlet.ps samlet.dvi 2> /dev/null

pdf: projekt
		@dvips -Ppdf -G0 samlet.dvi -o samlet.ps > /dev/null
		@ps2pdf -sPAPERSIZE=a4 -dMaxSubsetPct=100 -dCompatibilityLevel=1.2 -dSubsetFonts=true -dEmbedAllFonts=true samlet.ps > /dev/null
		@rm samlet.dvi

#pdf:
#		$(PDFLATEX) samlet
#		$(PDFLATEX) samlet
#		$(PDFLATEX) samlet
#		@rm samlet.dvi
#		make clean

clean:
		@echo Removing all excess files ...
		@rm -rf *.aux *.log *.bbl *.blg *.toc *.lof *.lot *~ *.bmt *.mtc1 *.log
#		@rm -rf *.mtc *.mtc2 *.mtc3 *.mtc4 *.mtc5 *.mtc6 *.mtc7 *.ps
		@rm -rf *.mtc* *.ps

cleaner: clean
		@rm -f *.pdf *.dvi

view: projekt ps
		@echo Displaying project 
		@xdvi -expert samlet.dvi
		@make cleaner > /dev/null

see: pdf
		@see samlet.pdf
		@make cleaner

dn:
		@echo Compiling Dynamic Network chapter
		$(LATEX) dnetwork/makechapter
		$(LATEX) dnetwork/makechapter
		$(LATEX) dnetwork/makechapter
		make clean
		@mv makechapter.dvi DynamicNetworking.dvi


CTANUPLOAD=ctanupload

CONTRIBUTION  = fancytabs
VERSION       = v1.8
SUMMARY       = Fancy page border tabs with Tikz
NAME          = Raphaël Pinson
EMAIL         = raphink@gmail.com
DIRECTORY     = /macros/latex/contrib/$(CONTRIBUTION)
DONOTANNOUNCE = 0
LICENSE       = free
FREEVERSION   = lppl
FILE          = $(CONTRIBUTION).tar.gz

SOURCEFILES   = $(CONTRIBUTION).dtx $(CONTRIBUTION).ins
PKGFILES      = $(CONTRIBUTION).sty
DOCFILES      = $(CONTRIBUTION).pdf

export CONTRIBUTION VERSION NAME EMAIL SUMMARY DIRECTORY DONOTANNOUNCE ANNOUNCE NOTES LICENSE FREEVERSION FILE

# default rule
ctanify: $(FILE)

$(FILE): README $(SOURCEFILES) $(DOCFILES) $(PKGFILES)
	ctanify --pkgname $(CONTRIBUTION) $^

%.sty: %.dtx %.ins
	latex $*.ins

$(CONTRIBUTION).pdf: $(CONTRIBUTION).sty
	pdflatex -interaction=batchmode $(CONTRIBUTION).dtx
	pdflatex -interaction=batchmode $(CONTRIBUTION).dtx

upload: ctanify
	$(CTANUPLOAD) -p

%.tds.zip: %.tar.gz
	tar xzf $< $@

install: $(CONTRIBUTION).tds.zip
	unzip $< -d $(TEXINSTALLDIR)
	mktexlsr

test: $(CONTRIBUTION)-test.pdf

clean:
	rm -f *.aux *.glo *.idx *.log
	rm -f $(DOCFILES) $(PKGFILES)
	rm -f $(FILE)


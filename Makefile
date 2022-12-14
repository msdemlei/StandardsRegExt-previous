# ivoatex Makefile.  The http://ivoa.net/documents/notes/IVOATex 
# for the targets available.

STILTS?=stilts

DOCNAME = StandardsRegExt

# count up; you probably do not want to bother with versions <1.0
DOCVERSION = 1.1

# Publication date, ISO format; update manually for "releases"
DOCDATE = 2023-01-15

# What is it you're writing: NOTE, WD, PR, REC, PEN, or EN
DOCTYPE = WD

# An e-mail address of the person doing the submission to the document
# repository (can be empty until a make upload is being made)
AUTHOR_EMAIL=renaud.savalle@obspm.fr

# Source files for the TeX document (but the main file must always
# be called $(DOCNAME).tex)
SOURCES = $(DOCNAME).tex role_diagram.pdf sia-example.vor

# List of image files to be included in submitted package (anything that
# can be rendered directly by common web browsers)
FIGURES = role_diagram.svg

# List of PDF figures (figures that must be converted to pixel images to
# work in web browsers).
VECTORFIGURES = 

# Additional files to distribute (e.g., CSS, schema files, examples...)
AUX_FILES = StandardsRegExt-v1.0.xsd

-include ivoatex/Makefile

ivoatex/Makefile:
	@echo "*** ivoatex submodule not found.  Initialising submodules."
	@echo
	git submodule update --init

test:
	@$(STILTS) xsdvalidate \
		schemaloc='http://www.ivoa.net/xml/VOResource/v1.0=https://www.ivoa.net/xml/VOResource/VOResource-v1.1.xsd' \
		StandardsRegExt-v1.0.xsd
	@$(STILTS) xsdvalidate \
		schemaloc=’http://www.ivoa.net/xml/StandardsRegExt/v1.0=StandardsRegExt-v1.0.xsd’ \
		schemaloc=’http://www.ivoa.net/xml/VODataService/v1.1=https://www.ivoa.net/xml/VODataService/v1.1’ \
		sia-example.vor
	@$(STILTS) xsdvalidate \
		schemaloc=’http://www.ivoa.net/xml/StandardsRegExt/v1.0=StandardsRegExt-v1.0.xsd’ \
		StandardsRegExt.vor

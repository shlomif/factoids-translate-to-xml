all: f2.xml f3.xml f8.xml

f2.xml: trans1.xslt Factoids.xml
	xsltproc -o $@ trans1.xslt Factoids.xml

f3.xml: f2.xml
	xmllint --format $< > $@

f6.xml: f5.xml trans2.xslt
	xsltproc -o $@ trans2.xslt f5.xml

f7.xml: f6.xml trans3.xslt
	xsltproc -o $@ trans3.xslt f6.xml

f8.xml: f7.xml
	xmllint --format $< > $@

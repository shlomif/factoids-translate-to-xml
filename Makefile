all: f2.xml

f2.xml: trans1.xslt Factoids.xml
	xsltproc -o $@ trans1.xslt Factoids.xml

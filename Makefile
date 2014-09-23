all: f2.xml f3.xml

f2.xml: trans1.xslt Factoids.xml
	xsltproc -o $@ trans1.xslt Factoids.xml

f3.xml: Transform.pl f2.xml
	perl Transform.pl f2.xml $@

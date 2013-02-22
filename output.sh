#!/bin/bash
# output.sh

rm -f errors*.txt

process() {
xmlstarlet val --err --list-bad --xsd /usr/share/xml/docbook/schema/xsd/5.0/docbook.xsd $1.xml >> errors-validate.txt 2>&1
xsltproc /usr/share/xml/docbook/stylesheet/docbook-xsl-ns/fo/docbook.xsl $1.xml > $1.fo 2> errors-fop.txt
fop -fo $1.fo -pdf $1.pdf > errors-pdf.txt 2>&1
fop -fo $1.fo -rtf $1.rtf > errors-rtf.txt 2>&1
xsltproc /usr/share/xml/docbook/stylesheet/docbook-xsl-ns/html/docbook.xsl $1.xml > $1.html 2> errors-html.txt
lynx -dump $1.html > $1.txt 2> errors-txt.txt
}

process backplane8
process busmonitor
process cassette
process colorvdu
process diskiov3
process propio
process sbcv2

exit 0

#!/bin/bash -ex

rm -rf generated-xml
mkdir generated-xml
for f in *.asciidoc
do
    BN=`basename $f`
    FILEID="${BN%.asciidoc}"
    if [ "$FILEID" != "yesod-web-framework-book" -a "$FILEID" != "pr01" -a "$FILEID" != "book" ]
    then
        DEST="generated-xml/${FILEID}.xml"
        asciidoc -b docbook45 --attribute=idprefix="${FILEID}_" -o "$DEST" "$f"
        runghc strip-article-info.hs "$DEST"
    fi
done

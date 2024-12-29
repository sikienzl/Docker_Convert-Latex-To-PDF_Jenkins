#!/bin/bash

help() {
    BASHSCRIPTNAME=$(basename "$0")
    echo "Please run the script as followed: "
    echo "$BASHSCRIPTNAME <TEXFILE>.tex"
}

# Überprüfen, ob eine .tex-Datei übergeben wurde
TEXFILE=$1

if [[ ! "$TEXFILE" == *.tex ]]
then
    echo "$TEXFILE not a tex file!"
    help
    exit 1
fi

if [[ ! -f "$TEXFILE" ]]
then
    echo "$TEXFILE does not exist!"
    help
    exit 1
fi

FILENAME="${TEXFILE%.*}"
PDFFILENAME="$FILENAME.pdf"

echo "########################################################"
echo "######start to convert $TEXFILE into $FILENAME.pdf######"
echo "########################################################"

# Kompilierung des LaTeX-Dokuments
pdflatex $TEXFILE
biber $FILENAME.bcf
pdflatex $TEXFILE
pdflatex $TEXFILE
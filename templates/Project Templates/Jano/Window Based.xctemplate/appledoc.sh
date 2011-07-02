#!/bin/bash

PACKAGENAME=___PACKAGENAME___
COMPANYID="com.yourcompany"
COMPANYNAME="___ORGANIZATIONNAME___"

if [ "./$PACKAGENAME" != "$(dirname $0)" ];
then
    echo "Call this script as ./$PACKAGENAME/appledoc.sh not as $S2/appledoc.sh"
    exit 1
fi

# Uncomment this when generation breaks to inspect the offending file.
# Remember that ampersands inside comments should be escaped (&amp;).
#KEEPFILES=--keep-intermediate-files
KEEPFILES= 

# Generate HTML only and skip docset generation.
#NODOCSET=--no-create-docset
NODOCSET=

# Is the appledoc tool in the PATH?
# To create appledoc you have to build and get the resulting product "appledoc" from the DerivedData directory.
hash appledoc 2>&- || { echo >&2 "appledoc is not in the PATH. Aborting."; exit 1; }

# are the templates ready?
if [ ! -f ~/Library/Application\ Support/appledoc/html/index-template.html ];
then
    echo "Template files are missing. Do this:"
    echo "    git clone git://github.com/tomaz/appledoc.git"
    echo "    mkdir -p ~/Library/Application\ Support/appledoc"
    echo "    cd appledoc"
    echo "    cp -vr Templates/ ~/Library/Application\ Support/appledoc"
    exit;
fi

# Run appledoc
appledoc --company-id $COMPANYID --project-company $COMPANYNAME \
--project-name $PACKAGENAME \
--output ./help             \
--ignore ./$PACKAGENAME/Classes/libraries \
--ignore ./$PACKAGENAME/Classes/support   \
$NODOCSET  \
$KEEPFILES \
./$PACKAGENAME/Classes

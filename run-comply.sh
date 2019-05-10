#!/bin/bash

# Comment the first 2 if you don't have a ticketing intergration yet
# update ticketing status
comply sync
# trigger creation of scheduled tickets
comply scheduler
# build latest
comply build

# Let's copy the admin and potential uploads to the output/ folder
cp -R static/* output/

# If the uploads folder is absent, we create it for Netlify CMS.
mkdir -p output/static/uploads

# Replace "[Build date]" with the UTC build date in the footer
OUTPUT_INDEX="output/index.html"
INDEX_CONTENT=$(sed "s/\[Build date\]/$(date -u)/" $OUTPUT_INDEX)
echo "$INDEX_CONTENT" > $OUTPUT_INDEX
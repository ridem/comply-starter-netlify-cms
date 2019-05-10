#!/bin/bash

# Comment the first 2 if you don't have a ticketing intergration yet
# update ticketing status
comply sync
# trigger creation of scheduled tickets
comply scheduler
# build latest
comply build

cp -R static/* output/

# If the uploads folder is absent, we create it folder Netlify Dev.
mkdir -p output/static/uploads

OUTPUT_INDEX="output/index.html"
INDEX_CONTENT=$(sed "s/\[Build date\]/$(date -u)/" $OUTPUT_INDEX)
echo "$INDEX_CONTENT" > $OUTPUT_INDEX
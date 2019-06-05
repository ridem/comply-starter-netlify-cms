#!/bin/bash

./run-comply.sh

## Post-processing ##

# Let's copy the admin and potential uploads to the output/ folder
cp -R static/* output/

# Add the build date with the UTC build date in the footer. Useful because we're doing static builds.
FROM=" data-last-edit-date>"
DATE=">Last edit: $(git --no-pager log -1 --format=%ci --date=default)"
HTML="output/index.html"
awk "{sub(\"$FROM\",\"$DATE\")}1" $HTML > $HTML.tmp && mv -f $HTML.tmp $HTML
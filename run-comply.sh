#!/bin/bash

# Comment the first 2 if you don't have a ticketing intergration yet
# update ticketing status
comply sync
# trigger creation of scheduled tickets
comply scheduler
# build latest
comply build
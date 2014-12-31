#!/bin/sh


svn status | grep '?' | cut -d '?' -f2 | xargs rm -rfsvn status | grep '?' | cut -d '?' -f2 | xargs rm -rf

#!/bin/bash
#

git add -A
git commit -m "`pwd | rev | cut -d/ -f1 | rev`"
git push

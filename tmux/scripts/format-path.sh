#!/usr/bin/env bash
sed "s|$HOME|~|g" < /dev/stdin | awk -F '/' '{if(NF > 3){print "…/"$(NF-1)"/"$(NF)}else{print}}'

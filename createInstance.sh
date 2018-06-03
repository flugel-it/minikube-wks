#!/usr/bin/env bash

echo "Use local aws credential? (yes / no)"
read OPTION

if [ ${OPTION} == 'yes' ]; then

elif [ ${OPTION} == 'no' ]; then

else
    exit 1
fi
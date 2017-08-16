#!/bin/bash

sample() {
if [ $1 -eq 0 ]; then 
	echo SUceess
else
	echo Failure
fi
}

### Main
false
sample $?

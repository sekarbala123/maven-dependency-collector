#!/bin/bash
# Author:  Balasekar Natarajan <sekarbala123@gmail.com>
# Read input for Main Project Path and Output Path
path=$1
outputPath=$2

if [ -z $outputPath ]; then
	echo "defaulting output path to : dep-list"
	echo "Note any existing files in this path is overwritten"
	outputPath=$path/'dep-list'
fi

# set the current working directory to the path
cd $path

# find all the pom files in the project and associated sub-project

find . -maxdepth 2 -name pom.xml | while read fname; do

	echo Pom.xml location : $fname

	bname=$(basename $fname)
	dname=$(dirname $fname)

	#trimmed directory name
	tdname=${dname##*/}

	echo  Base name: $bname , Directory name: $dname, Trimmed directory name: $tdname
	outfile="$outputPath/$tdname-dependency-tree.txt"

	echo outfile path $outfile
	mvn dependency:tree -DoutputFile="$outfile" -f "$fname"
done

#!/bin/bash

#get roll number as the first argument
roll_number=$1

#initialize i to zero to keep track of marks
i=0


#loop through csv files
for file in *.csv; do
    fname=$(basename "$file" .csv)

    #if the file is not main.csv, then get the marks for the roll number
    if [ "$fname" != "main" ]; then
    #get the marks for the roll number
        marks=$(grep $roll_number, $file | cut -d',' -f3)
        #if marks are found, print the marks
        if [ -n "$marks" ]; then
            echo "Marks for roll number $roll_number in $fname: $marks"
        fi
    fi
done

#Check main.csv to get the total marks
for file in main.csv; do
    #get the total marks for the roll number
    marks=$(grep $roll_number, $file | rev | cut -d',' -f1 | rev)
        if [ -n "$marks" ]; then
            echo "Total marks for roll number $roll_number: $marks"
            i=1
        fi
done

#if marks are not found, print a message
if [ $i -eq 0 ]; then
    echo "No marks found for roll number $roll_number"
fi
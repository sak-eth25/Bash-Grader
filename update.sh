#!/bin/bash

read -p "Roll Number of the student whose marks need to be chaged:" rollno

#Looping through all the csv files
for file in ./*.csv;do

    #Assingning a variable fname to store filename
   fname=$(basename "$file" .csv)

    #Reading all csv files other than main.csv
   if [ "$fname" != "main" ]; then
    
    #check wether the marks of a student are presnt in the file of given exam
    rollno_found=0
    if [[ $(awk -v roll="$rollno" -F ',' '$1 == roll' "$file") ]]; then
            rollno_found=1
    fi


    #if the marks are present rollno_found would be 1 and then we can change the file
    if [ "$rollno_found" == "1" ];then
        read -p "Marks in $fname:" updmarks
        #change the marks of that roll no in the file of that exam
        sed  -Ei "/^$rollno,/s/([A-Za-z0-9]+,)(.*,).*/\1\2$updmarks/" "$file" 
    fi


   fi
done


#combine again just in case if anything is changed
bash combine.sh

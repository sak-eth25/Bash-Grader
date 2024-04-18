#!/bin/bash

read -p "Roll Number of the student whose marks need to be chaged:" rollno
read -p "Name of the student:" name


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



    if [ "$rollno_found" == "1" ];then

        #if the marks are present rollno_found would be 1 and then we can change the file
        read -p "Marks in $fname(Enter -1 to remove marks of $rollno in $fname):" updmarks
        if [ "$updmarks" -ne "-1" ]; then
            #change the marks of that roll no in the file of that exam
            sed  -Ei "/^$rollno,/s/([A-Za-z0-9]+,)(.*,).*/\1\2$updmarks/" "$file"
            else
            sed  -Ei "/^$rollno,/d" "$file"
        fi 

    else
        #if the marks are not present then they can be added or not depending on the input
        read -p "Marks in $fname (Enter -1 if absent):" updmarks

        if [ "$updmarks" -ne "-1" ]; then
            echo "$rollno,$name,$updmarks">>$file
        fi

    fi


   fi
done


#combine again just in case if anything is changed
bash combine.sh

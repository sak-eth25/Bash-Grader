#!/bin/bash

#Create main.csv
touch main.csv
echo "Roll_Number,Name" > main.csv

#Looping through all the csv files
for file in ./*.csv;do

    #Assingning a variable fname to store filename
    fname=$(basename "$file" .csv)

    #Reading all csv files other than main.csv
    if [ "$fname" != "main" ]; then

        #adding exam name in headings
        sed -i "1s/$/,$fname/" main.csv
        
        #fcol is used to get the column number of the particular exam
        fcol=$(awk -F ',' 'NR==1 {for(i=1;i<=NF;i++) if($i=="'$fname'") print i}' main.csv)

        #need to add absent for previous exams when a new name is being added
        abs=$(
            for (( i = 0; i < $fcol-3; i++ )); do
                echo ",a"
            done
        )

        while IFS="," read -r first second third || [ -n "$first" ]; 
        do
            rollno="$first"
            name="$second"
            marks="$third"
            
            if [ "$name" != "Name" ]; then
                if grep -q "^$rollno," main.csv; then
                    #Checks for line starting with the particular roll number and replaces ending of that line with marks
                    sed -i "/^$rollno,/ s/$/,$marks/" main.csv

                    #adding name and roll number to the list if it wasn't previously present and marking absent by using $abs
                    else echo "$rollno,$name$abs,$marks">>main.csv
                fi
            fi
            
        done < "$file"
         #check wether the person is present or not by checking th fcol column of each line in main.csv
        while IFS="," read -r -a fields; do
            if [ ${#fields[@]} -lt $fcol ];then
            #no of elements are less means the last element is missing which has to be a
              absrollno=${fields[0]}
              sed -i "/^$absrollno,/ s/$/,a/" main.csv
            fi
        done < "main.csv"
    fi
done

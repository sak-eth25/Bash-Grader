#!/bin/bash



#---------------------------------UPLOAD---------------------------------#

# Check if the first command-line argument is "upload"
if [ "$1" == "upload" ]; then

    #check if there are more than two arguments
    if [ $# -eq "2" ]; then
        #copies the given file into current directory if there are only two arguments
        cp $2 ./
        #else gives the message of correct format
        else echo "Required format to copy a .csv file is 'bash submission.sh upload (absolute path to the file)'" 
    fi
fi


#---------------------------------TOTAL---------------------------------#

# Check if the first command-line argument is "total"
if [ "$1" == "total" ]; then

    # Read the first line of the CSV file
    read -r first_line < main.csv

    #check wether total is already present
    if [[ "$first_line" =~ \,Total$ ]]; then
        #Do nothing
        sed -i "1s/,Total$/,Total/" main.csv

        else 
            #adding headin total to main.csv
            sed -i "1s/$/,Total/" main.csv   

    fi

    cp main.csv temp.csv
    #total.awk has an awk script to do total and add it to the line
    awk -f total.awk temp.csv > main.csv
    rm temp.csv
   
fi


#---------------------------------UPDATE---------------------------------#


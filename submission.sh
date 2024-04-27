#!/bin/bash

#---------------------------------COMBINE---------------------------------#
# Check if the first command-line argument is "combine"
if [ "$1" == "combine" ]; then
    bash combine.sh
fi



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
# Check if the first command-line argument is "update"
if [ "$1" == "update" ]; then
    bash update.sh
fi


#---------------------------------GIT_INIT---------------------------------#
# Check if the first command-line argument is "git_init"
if [ "$1" == "git_init" ]; then
    bash gitinit.sh $2
fi

#---------------------------------GIT_COMMIT---------------------------------#
# Check if the first command-line argument is "git_commit"
if [ "$1" == "git_commit" ] & [ "$2" == "-m" ]; then
    bash gitcommit.sh $3
fi

#---------------------------------GIT_CHECKOUT---------------------------------#
# Check if the first command-line argument is "git_checkout"
if [ "$1" == "git_commit" ] && [ "$2" == "-m" ]; then
    bash gitcommit.sh "$3"
fi
if [ "$1" == "git_commit" ] && [ "$2" != "-m" ]; then
    echo "bash submission.sh git_commit -m "Commit Message""
fi

#---------------------------------GIT_LOG---------------------------------#
# Check if the first command-line argument is "git_log" and print the log file
if [ "$1" == "git_log" ]; then
    cat ~/.bggit/.stor/log
fi

#---------------------------------GIT_CLEAN---------------------------------#
# Check if the first command-line argument is "git_clean" to delete .bggit directory
if [ "$1" == "git_clean" ]; then
    rm -r ~/.bggit
    echo "git removed"
fi

#---------------------------------GRAPHS---------------------------------#
# Check if the first command-line argument is "graph"
if [ "$1" == "graph" ]; then
    python3 graphs.py
fi


#---------------------------------STATS---------------------------------#
# Check if the first command-line argument is "stats"
if [ "$1" == "stats" ]; then
    python3 stats.py
fi
import os
import numpy as np
import csv

# Function to calculate marks from a given csv file
def marks(filename):
    # Initialize an empty dictionary to store marks
    marks = {}
    
    # Open the csv file
    file = open(filename, "r")
    
    # Create a csv reader object
    reader = csv.reader(file)
    
    # Skip the heading row
    headers = next(reader)
    
    # Iterate through each row in the csv
    for row in reader:
        # Store the marks in the dictionary with rollno as key
        marks[row[0]] = int(row[2])
        
    # Return the dictionary containing marks
    return marks

# Iterate through each file in the current working directory
for filename in os.listdir(os.getcwd()):
    # Check if the file is a csv file and not named "main.csv"
    if filename.endswith(".csv") and filename!= "main.csv":
        # Calculate marks from the csv file
        marksdict = marks(filename)
        
        # Extract keys and values from the dictionary as lists
        x = list(marksdict.keys())
        y = list(marksdict.values())
        
        # Calculate average, median, standard deviation, max, and min marks
        averagemarks = np.mean(y)
        median = np.median(y)
        std = np.std(y)
        max = np.max(y)
        min = np.min(y)
        
        # Print the results for each exam
        print("\033[4m" + (os.path.splitext(filename)[0]).upper() + "\033[0m" + ":")
        print("Average Marks=" + str(averagemarks))
        print("Median=" + str(median))
        print("Standard Deviation=" + str(std))
        print("Highest=" + str(max))
        print("Lowest=" + str(min))
        print("---------------------------------------------------------------")

# Calculate stats for the "main.csv" file
#Dictionary of roll no and corresponding total marks
marksdict = {}
file = open("main.csv", "r")
reader = csv.reader(file)
headers = next(reader)

for row in reader:
    marksdict[row[0]] = int(row[-1])

x = list(marksdict.keys())
y = list(marksdict.values())

averagemarks = np.mean(y)
median = np.median(y)
std = np.std(y)
max = np.max(y)
min = np.min(y)

# Print the results for total
print("\033[4m" + "TOTAL" + "\033[0m" + ":")
print("Average Marks=" + str(averagemarks))
print("Median=" + str(median))
print("Standard Deviation=" + str(std))
print("Highest=" + str(max))
print("Lowest=" + str(min))
print("---------------------------------------------------------------")
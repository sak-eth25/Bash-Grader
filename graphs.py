import csv
import numpy as np
import matplotlib.pyplot as plt
import os
import random


#function to get marks of a student in a particular exam as a dictionary
def marks(filename):
    marks = {}
    file=open(filename,"r")
    reader = csv.reader(file)
    #skip the heading row
    headers = next(reader)
    for row in reader:
           #give marks[rollno]=(marks in that test)
           marks[row[0]]=int(row[2])
    return marks

#get no of .csv files other than main.csv to find the no of rows and columns in the plot
no_of_files=0

for filename in os.listdir(os.getcwd()) :
      if filename.endswith(".csv"):
            no_of_files+=1

#Serial number ot the graph is i
i=1

#plotting the graph for exams seperately
for filename in os.listdir(os.getcwd()) :
      if filename.endswith(".csv") and filename != "main.csv":
            marksdict=marks(filename)
            x=list(marksdict.keys())
            y=list(marksdict.values())
            averagemarks=np.mean(y)
            plt.subplot(2,int(no_of_files/2 + 0.5),i)
            #setting random color for each graph
            color = (random.random(), random.random(), random.random())
            #Drawing a line for average marks and mentions the average marks
            plt.axhline(averagemarks, color='r', linestyle='--', label="Mean: {:.2f}".format(averagemarks))
            plt.plot(x,y, marker="*", color=color)
            plt.xlabel("Roll No.")
            plt.ylabel("Marks")
            #Setting title as the name of the exam
            plt.title(os.path.splitext(filename)[0])
            plt.legend()
            # Add y-coordinate values at each point in the graph
            for x_val, y_val in zip(x, y):
                plt.text(x_val, y_val, str(y_val), ha='center')
            i+=1

#Plotting graph for total marks
#Dictionary of roll no and corresponding total marks
marksdict = {}
file = open("main.csv", "r")
reader = csv.reader(file)
headers = next(reader)

for row in reader:
    marksdict[row[0]] = int(row[-1])
x = list(marksdict.keys())
y = list(marksdict.values())
averagemarks=np.mean(y)
plt.subplot(2,int(no_of_files/2 + 0.5),i)
color = (random.random(), random.random(), random.random())
#Drawing a line for average marks and mentioning avg marks in legend
plt.axhline(averagemarks, color='r', linestyle='--', label="Mean: {:.2f}".format(averagemarks))
plt.plot(x,y, marker="*", color=color)
plt.xlabel("Roll No.")
plt.ylabel("Marks")
plt.title("Total")
plt.legend()
# Add y-coordinate values at each point in the graph
for x_val, y_val in zip(x, y):
    plt.text(x_val, y_val, str(y_val), ha='center')



#adjusting the space between subplots
plt.subplots_adjust(wspace=0.6, hspace=0.6)
#Shows the plots
plt.show()
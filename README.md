# Teaching Assistant Eligibility Predictor using R-Shiny Application

# Problem Statement:
Identification of eligible students for the Teaching Assistant position in University of North Texas.

# DATA DICTIONARY

Column Name Data Type Description Sample Values Number of unique Values
Name String Candidate's full name [John, doe….] N/A
Semester String Academic semester of the candidate (e.g., Freshman, Sophomore, Junior, Senior) [Freshman, Junior….] 4
Professional Experience String Indicates whether the candidate has professional experience (Yes/No) [Yes, NO] 2
GPA Float Candidate's Grade Point Average [3.5, 3.8…..] N/A
Number of Lor’s Integer Number of Letters of Recommendation the candidate has [0,1, 2..] N/A
Projects outside of academics Integer Number of projects the candidate has been involved in outside academics [0,1, 2..] N/A
TA Result Integer Indicates whether the candidate was selected as a TA (1 for yes, 0 for no) [0,1] 2

Students need to provide their personal information to check their eligibility(probability score).

# Technologies used: R Studio, R-Shiny web application
# Programming Language: R

# Machine Learning Models: Artificial Neural Networks, Logistic, Lasso, Ridge Regression models.

We(My team) practiced these 4 machine learning models to get the expected values.

Out of these models used, ANN model gave us best accuracy scores.
 Accuracy: 92%
 Sensitivity: 92%
 Specificity: 100%

# Confusion Matrix:
Prediction Reference
 0 1
0 208 0
1 17 15

For whom this application is useful:
For Students:
After providing their personal information to the application, model will start running and provide the results in probabilistic scores[0, 1]. 
Then students can expect whether they will receive an interview call from the department advisor.

For Advisor:
Records will be stored in an excel file for those students who are checking their probabilistic scores.
So, advisor can decide the cut-off score(ex: 0.7 or 0.8 etc.) based on the open positions.

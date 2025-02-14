# Teaching Assistant Eligibility Predictor 🎓 using Deep Learning Models                                                                                        
🔗 Live R-Shiny App: [Click here](https://github.com/RakeshsarmaKarra/Teaching-Assistant-Prediction-ML-/blob/main/TA%20Identification%20Project.R)                       
📂 Project Type: Machine Learning Web Application                                                                                                             
🛠 Technologies Used: R Studio, R-Shiny

## 📌 Problem Statement
The University of North Texas seeks an efficient way to identify eligible students for the Teaching Assistant (TA) position. This application predicts TA eligibility based on key academic and professional factors, providing probabilistic scores for both students and advisors.

## 📊 Data Dictionary
| Column Name               | Data Type | Description                                             |
|---------------------------|----------|---------------------------------------------------------|
| Name                      | String   | Candidate's full name                                  |
| Semester                  | String   | Academic semester (Freshman, Sophomore, Junior, Senior) |
| Professional Experience   | String   | Indicates prior work experience (Yes/No)               |
| GPA                       | Float    | Candidate’s Grade Point Average                        |
| Number of LORs            | Integer  | Letters of Recommendation count                        |
| Projects outside Academics| Integer  | Number of external projects participated in            |
| TA Result                 | Integer  | TA selection result (1 = Yes, 0 = No)                  |

## ⚙️ Technologies & Models Used                                                                                                                      
Programming Language: **R**                                                                                                                                        
Framework: **R-Shiny (Web Application)**                                                                                                                         

**Machine Learning Models Tested:**                                                                                                                  
🔹 Artificial Neural Networks (ANN)                                                                                                                                       
🔹 Logistic Regression                                                                                                                                       
🔹 Lasso Regression                                                                                                                                       
🔹 Ridge Regression                                                                                                                                       
✅ Best Model: ANN                                                                                                                                       

## 📈 Performance Metrics:                                                                                                                                      
Accuracy: 92%                                                                                                                                       
Sensitivity: 92%                                                                                                                                       
Specificity: 100%                                                                                                                                       

## 📑 Confusion Matrix                                                                                                                                       
| Prediction \ Reference | 0 (Not Selected) | 1 (Selected) |
|------------------------|------------------|--------------|
| 0 (Predicted Not Selected) | 208              | 0            |
| 1 (Predicted Selected)     | 17               | 15           |

## 💡 How the Application Works                                                                                                              
**For Students:**                                                                                                              
📌 Enter your GPA, Semester, LORs, Projects, and Experience into the R-Shiny interface.                                                       
📌 The model predicts your eligibility score (between 0 and 1).                                                                                                              
📌 If your probability score is high, you have a better chance of getting a TA interview call.                                                       

**For Advisors:**                                                                                                              
📌 Student records are stored in an Excel file.                                                                                                              
📌 The department advisor can set a cutoff score (e.g., 0.7 or 0.8) based on open TA positions.                                                       

📸 Screenshots & Visualization for Web Application 

<a href="https://github.com/RakeshsarmaKarra/Teaching-Assistant-Prediction-ML-/blob/main/Web%20Application%20Interface.jpg">
    <img src="https://github.com/RakeshsarmaKarra/Teaching-Assistant-Prediction-ML-/blob/main/Web%20Application%20Interface.jpg" width="500">
</a>

## 🚀 How to Run the Application Locally                                                                                                             
1️⃣ Clone the Repository                                                                                                                                            
sh                                                                                                                                                       
Copy                                                                                                                                            
Edit                                                                                                                                            
git clone https://github.com/RakeshsarmaKarra/TA-Eligibility-Predictor.git                                                                                      
cd TA-Eligibility-Predictor                                                                                                                                            
2️⃣ Install Dependencies                                                                                                                                            
r                                                                                                                                                       
Copy                                                                                                                                            
Edit                                                                                                                                            
install.packages(c("tidyverse", "rpart", "leaps", "c3", "shinyWidgets", "plotly", "shiny", "bslib", "corrplot", "neuralnet"))                                      
3️⃣ Run the Application                                                                                                                                            
r                                                                                                                                            
Copy                                                                                                                                                                          
Edit                                                                                                                                            
shiny::runApp("app.R")

👥 Contributors                                                                                                                                            
👨‍💻 Rakesh Sarma Karra                                                                                                                                                        
👨‍💻 Sowmya Nomula

📬 Contact & Feedback
For any questions, feel free to reach out!

📧 Email: **rakeshsarmakarra@gmail.com**
📌 LinkedIn: [Click here](https://www.linkedin.com/in/rakesh-da/)



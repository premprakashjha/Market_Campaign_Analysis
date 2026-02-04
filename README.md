# 📈 Market Campaign Analysis

This project analyzes the effectiveness of marketing campaigns using **R programming** and **Excel data**.  
The goal is to uncover customer behavior patterns, identify high-value customer segments, and optimize marketing strategies.

---

## 📂 Repository Structure
Market_Campaign_Analysis/
│── data/ # Contains the Excel dataset(s)
│ └── market_campaign.xlsx
│── scripts/ # R scripts for data cleaning & analysis
│ └── analysis.R
│── README.md # Project documentation (this file)


---

## 🎯 Project Objectives
- Understand **customer demographics** (age, income, education, family size, etc.)  
- Analyze **product preferences** across categories (wine, meat, gold, sweets, etc.)  
- Evaluate the **effectiveness of past campaigns**  
- Segment customers into groups for targeted marketing  
- Provide **data-driven insights** to improve campaign performance  

---

## 🛠 Tools & Technologies
- **R Programming**
  - `tidyverse` → Data cleaning & manipulation  
  - `ggplot2` → Data visualization  
  - `caret` → ML/Classification (if used)  
  - `cluster`, `factoextra` → Customer segmentation  
- **Excel** → Dataset storage & preprocessing  
- **Git & GitHub** → Version control and sharing  

---

## 📊 Dataset Information
The dataset contains customer information such as:  

| Column                | Description |
|------------------------|-------------|
| `ID`                  | Unique customer ID |
| `Age`                 | Age of the customer |
| `Income`              | Yearly household income |
| `Education`           | Education level |
| `Marital_Status`      | Relationship status |
| `Num_Children`        | Number of children |
| `MntWines`            | Amount spent on wine |
| `MntMeatProducts`     | Amount spent on meat |
| `MntGoldProds`        | Amount spent on gold |
| `Campaign_Response`   | Whether the customer accepted the campaign |

*(Adjust table to match your actual dataset columns.)*

---

## 🔍 Analysis Performed
1. **Data Cleaning**  
   - Handled missing values & outliers  
   - Converted categorical variables to factors  

2. **Exploratory Data Analysis (EDA)**  
   - Income distribution by age & education  
   - Spending patterns by product type  
   - Correlation between income & spending  

3. **Campaign Performance**  
   - Success rate of campaigns  
   - Customer acceptance by income/age groups  

4. **Customer Segmentation (Clustering)**  
   - K-means clustering on spending behavior  
   - Identification of high-value customer segments  

5. **Visualization**  
   - Histograms, bar charts, scatterplots  
   - Cluster visualization  

---

## 📌 Key Insights
- Younger customers prefer **sweets & meat products**, while older customers spend more on **wine**.  
- High-income customers responded positively to premium product campaigns.  
- Campaign success was highest among **middle-aged, married customers** with moderate-to-high income.  
- Clustering revealed **3 main customer groups**:  
  - **Budget Shoppers** – low spend, low campaign acceptance  
  - **Average Consumers** – moderate spend across categories  
  - **Premium Buyers** – high income, loyal to campaigns  

---

## 🚀 How to Run the Project
1. Clone this repository:
   git clone https://github.com/premprakashjha/Market_Campaign_Analysis
   
   cd Market_Campaign_Analysis
3. Open the R script:

source("scripts/analysis.R")
3. Make sure you have the required libraries installed:

install.packages(c("tidyverse", "caret", "cluster", "factoextra", "ggplot2"))


4. Run the script to generate EDA, visualizations, and clustering results.

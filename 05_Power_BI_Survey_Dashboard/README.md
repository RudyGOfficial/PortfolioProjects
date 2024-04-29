# Power BI ETL & Dashboard Data Visualization Project
This project demonstrates the skills required to build a user friendly dashboard data visualization made with a transformed Excel datasheet.

## This Project Demonstrates the Following Power BI Skills:
1. Extract datasets from Microsoft Excel files into Power Query
2. Transform datasets using Power Query (see "Power Query Steps Taken" below)
3. Load transformed data into Power BI
4. Create charts based on the loaded data
5. Build a dashboard with dynamic charts for effective analysis

## How to Use the Project:
* Open the Data_Professional_Surveys file in Excel to view the raw dataset.
* Open the Power_BI_Survey_Dashboard file in Power BI and navigate to Report View to use the dashboard and Table View to compare the transformed data with the Excel raw dataset.

## Dashboard Breakdown
Here are all visualizations in the dashboard. Each data component of each chart can be selected to filter the entre dashboard.
* Count of Survey Takers: Card showing how many people took the survey.
* Average Age of Survey Taker: Card showing how old is the average respondent.
* Happy With Work/Life Balance: Gauge shows the average score on a scale from 0 to 10.
* Happy With Salary: Gauge shows the average score on a scale from 0 to 10.
* Average Salary by Job Title: Stacked bar chart shows all data positions and the average salary for each.
* Difficulty to Break Into Data: Donut chart shows how much of all surveys a particular difficulty level was selected.
* Country of Survey Takers: Treemap shows the countries of all respondents.
* Favorite Programming Language: Stacked Column Chart shows each programming language and how popular they are for each particular data job title

## Power Query Steps Taken
Here are the specific steps I took to transform the raw dataset. You can see the actual Power Queries by navigating to "Home > Queries > Transform Data" in the Power BI file:
1. Remove Columns: Browser, OS, City, Country, Referrer
2. Simplify Column "Q1 - Which Title Best Fits your Current Role?": Highlight Column > Home > Transform > Split Column > Custom "(" for Left-most delimiter
3. Remove Column made from above step: Right Click > Remove
4. Rename number from step 2 column name: Double-click > remove characters
5. Simplify Column "Q5 - Favorite Programming Language": change all other answers to "Other".
6. Clean "Q3 - Current Yearly Salary (in USD)" column: Make a duplicate to work with > split column's digits from non-digits > replace "+" with "225"
7. Add "Average Salary" Column: Add Column > Insert Column > Name "Average Salary" > Add this formula (after changing the data type for the columns in the formula): ([#"Q3 - Current Yearly Salary (in USD) - Copy.1"] + [#"Q3 - Current Yearly Salary (in USD) - Copy.2"]) / 2 > Remove the columns used to make the formula > change data type to decimal
8. Simplify Columns "Q11 - Which Country do you live in?", "Q4 - What Industry do you work in?"
9. Replace value in column "Q7 - How difficult was it for you to break into Data?": Replace "Neither easy nor difficult" with "Neutral"
10. Close & Apply Power Query

# SQL Covid Data Exploration
This project demonstrates fundamental SQL skills required to effectively explore & analyze datasets. The dataset used for this project pertains to COVID-19.
* Note: This project was originally conducted by importing CSV files as flat files into SSMS; therefore, some casted data types in the SQL queries may not match the Excel imports. If this is the case, then update the queries on the fly to demonstrate the SQL queries.

## This Project Demonstrates the Following Data Analysis Skills:
  1. Use CAST values to build a calculated field showing percentage of COVID cases & deaths
  2. Use aggregate fuctions to identify highest location/continent/global infection/death rates
  3. Use PARTITION BY to create a column displaying a rolling vaccination count & percentage
  4. Demonstrate Common Table Expressions (CTE), Temp Tables, & Table Views when implementing Skill #3.

 ## How to Setup the Project in Windows (Microsoft SQL Server / SSMS):
 Note: Due to frequent updates and multiple versions of Microsoft SQL Server / SSMS existing, the steps below can become out of date at any time and independent research is recommended to calibrate your imports/exports effectively.
   1. Open terminal and enter 'git clone <SSH_Link>' to clone the project (Note: Replace the link with the repository's SSH link). Alternatively, you can download from GitHub directly.
   2. Store the project in any directory
   3. Open SSMS: Open the SSMS program > Connect to Server > "Connect"
   4. After connecting to the server in SSMS, make a new database named "PortfolioProject"
   5. Import the Excel spreadsheet (details below)
   6. Open the SQL file (Shortcut "Ctrl + O")

## How to Import Datasets (SQL Server Import/Export Wizard):
Open SQL Server Import and Export Wizard by right-clicking the database "PortfolioProject", and going to "Tasks > Import Data". Steps 1-7 corresponds to each Window in the wizard.
  1. Welcome Window: If the welcome window pops up first, select "Next"
  2. Choose A Data Source: Change "Data Source" to "Microsoft Excel", Browse & select the excel spreadsheet to import, Adjust Excel version if needed, then Select "Next".
  3. Choose  Destination: Change "Destination" to "Microsoft OLE DB Provider for SQL Server", Make sure the Server Name & Database are correct, then select "Next".
  4. Specify Table Copy or Query: Select "Copy data from one or more tables or views" and then Select "Next"
  5. Select Source Tables and Views: Select the table that DOES NOT have "#_FilterDatabase" in its name, which means you will most likely select the first option if multiple options are present.
  6. Save and Run Package: Select "Run immediately" and then select "Next".
  7. Complete the Wizard: Ensure all settings you selected are accurate and then select "Finish".
  8. After importing successfully, close the wizard window & refresh the database.
  9. Navigate to the table: PortfolioProject > Tables > (All tables imported will display here)
  10. Rename the Table to match its filename if imported with a different name: Right click table > Rename > "File_Table_Name" > Enter
  11. Refresh server state: Right click table > "Select Top 1000 Rows" > Press "Ctrl + Shift + R".

# SQL Data Cleaning Project
This project uses a Nashville Housing Dataset to demonstrate various data cleaning skills that help make datasets more usable and intuitive for analysis. This project has the following files:
  * NashvilleHousing_Raw: Original dataset before cleaning was conducted
  * NashvilleHousing_Clean: Cleaned dataset after running SQL queries
  * NashvilleHousingDataCleaning: SQL file containing all statements used to clean & queries to help visualize before/after

## This Project Demonstrates Six Data Cleaning Skills:
	1. Date formatting (from DateTime to Date)
	2. Populate address data from one column to another where data is NULL
	3. Parsing address columns and splitting their substrings into separate columns
	4. Standardize Yes/No column to have Yes/No values only
	5. Remove rows considered as 'duplicate' based on certain criteria
	6. Drop unusable columns (as a project demonstration only)

## Note the Following Points Regarding This Project:
	* Each skill demonstration contains a before, cleaning, and after section.
	* Before sections use the raw table to demonstrate how the table looked before cleaning
	* Cleaning sections contain the actual queries used to clean the table (DO NOT RUN AGAIN!)
	* After sections use the clean table to demonstrate results
	* Note: certain queries were updated to accomodate for missing columns (ex: PropertyAddress) for demonstration

 ## How to Setup the Project in Windows (Microsoft SQL Server / SSMS):
 Note: Due to frequent updates and multiple versions of Microsoft SQL Server / SSMS existing, the steps below can become out of date at any time and independent research is recommended to calibrate your imports/exports effectively.
   1. Open terminal and enter 'git clone <SSH_Link>' to clone the project (Note: Replace the link with the repository's SSH link). Alternatively, you can download from GitHub directly.
   2. Store the project in any directory
   3. Open SSMS: Open the SSMS program > Connect to Server > "Connect"
   4. After connecting to the server in SSMS, make a new database named "PortfolioProject"
   5. Import the "NashvilleHousing_Raw" Excel spreadsheet (details below)
   6. Import the "NashvilleHousing_Clean" Excel spreadsheet (details below)
   7. Open the "NashvilleHousingDataCleaning" SQL file (Shortcut "Ctrl + O")

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

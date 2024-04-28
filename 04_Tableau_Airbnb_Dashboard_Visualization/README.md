# Tableau Dashboard Data Visualization Project
This project demonstrates my skills as a Data Analyst hired by an individual who wants to start an Airbnb business. In this scenario, they need to know what factors they should consider so they know where to buy a home that will then be placed on Airbnb to rent. For example, this home will be lived in and rented out at peak times throughout the year. In addition, when comparing homes, they want to compare by bedroom count and analyze what competition exists in the current Airbnb market.

To help this individual with their request, I created five different data visualizations (i.e.: graphs) and then displayed them all on a dashboard on Tableau. They can use this dashboard to guide their business decisions. See a breakdown of each graph below and then a quick guide on how I imported the dataset and built the dashboard.

## This Project Demonstrates the Following Tableau Skills:
1. Importing Excel Workbooks
2. Join tables by shared columns
3. Build bar, line, map, and text graphs
4. Create dashboard data visualizations

## How to View the Project:
Go to this link: https://public.tableau.com/app/profile/rudolph.gutierrez/viz/Airbnb_Dashboard_Visualization/Dashboard1

## Graph Details
Here are all details that went into building each graph in the dashboard data visualization.

### Sheet One: Bar Graph
* Graph Name: Price by Zip Code
* Column: Listing's Zip Code (exclude NULLS)
* Rows: Listing's Price (Drop-down menu > Measure > Average)
* Marks: Listing's Zip Code (color)
* Sort: Descending (most to least expensive)

### Sheet Two: Map Graph
* Graph Name: Price per Zip Code
* Column: Listing's Zip Code (Select "Show Me > Map" after dragging zipcode to Columns)
* Rows: (Becomes Latitude after following step in Column)
* Marks: Listing's Zip Code (label), Listing's Zip Code (color), Listing's "AVG" Price (label), adjust size of labels

### Sheet Three: Line Graph
* Graph Name: Revenue for Year
* Column: Calendar's Date (Drop-down menu > Filter for 1/1/16-12/31/16 > break up data by year with each year split by week)
* Rows: Calendar's Price

### Sheet Four: Bar Graph
* Graph Name: Avg Price per Bedroom
* Column: Listing's Bedrooms (Convert to dimension > Drag to columns > Remove "NULL" & "0")
* Rows: Listing's "AVG" Price (drop-down menu > measure > average)
* Marks: Listing's "AVG" Price (label)

### Sheet Five: Table
* Table Name: Distinct Count of Bedroom Listings
* Rows: Listing's Bedrooms - Dimension
* Marks: Listing's Id as Label (Drag to Marks > Drop-down menu > Measure: "Count (Distinct)")
* Filters: Listing's Bedrooms - Dimension (uncheck NULL & 0)

## Tableau Quick Guide
Here's a basic tutorial on how I created, build, & saved the Tableau file:
1. Import Excel workbook: Tableu > To a File: Microsoft Excel > Select workbook > click "Open"
2. Join Listings & Calendar Excel tables: Data Source > Drag "Listings" > Drag "Calendar" > Inner Join on listing's "Id" column & Calendar's "Listing Id" column
3. Create Dashboard: Make graphs > Make new dashboard > Change Size's Range to "Automatic" > Drag & drop graphs and adjust as needed
4. Save to Tableau: File > Save to Tableau Public As > Name the Tableau project > Save

# Python & Jupyter Notebook Crypto API Pull Project
This project demonstrates how to use Python & Jupyter Notebook to pull cryptocurrency data from an API and use the resulting json to create/update a CSV, DataFrame, and visualization. This script works for Windows only.

## This Project Demonstrates the Following Python & Jupyter Notebook Skills:
1. Pull JSON data from a crypto website's API
2. Transform JSON to a DataFrame & export as CSV
3. Analyze, clean, and create a visualization from the DataFrame

## How to Use the Project:
1. Clone the repository into a directory of your choice on your computer
2. Run Jupyter Notebook in browser
3. Navigate to the cloned project and open "Crypto_Website_API_Pull.ipynb"
4. Run script: Kernel > Restart & Run All
5. Wait n seconds for AutoAPIRunner method to pull crypto data n times. By default, the method pulls 5 times (once every 60 seconds).
6. Once all kernels are done running, view the visualization in the final cell

## Project Customization Guide:
#### Change how many unique cryptos are pulled
* Cell 02 > Line 10 > 'limit': change the number
#### Change DataFrame display options
* Cell 02 > Line 21-22: change display setting as preferred
#### Change API pull counter & interval
* Cell 04 > Line 02: change 'counter' for number of pulls and 'interval_sec' for time between pulls.
#### Review each transformation and final visualization
* Cell 06 > Line 01-11: comment/uncomment variables to see how each step looked

/*
SQL Data Cleaning Project

This project demonstrates six data cleaning skills:
	1. Date formatting (from DateTime to Date)
	2. Populate address data from one column to another where data is NULL
	3. Parsing address columns and splitting their substrings into separate columns
	4. Standardize Yes/No column to have Yes/No values only
	5. Remove rows considered as 'duplicate' based on certain criteria
	6. Drop unusable columns (As a project demonstration only)

Note the following points regarding this project:
	* Each skill demonstration contains a before, cleaning, and after section.
	* Before sections use the raw table to demonstrate how the table looked before cleaning
	* Cleaning sections contain the actual queries used to clean the table (DO NOT RUN AGAIN!)
	* After sections use the clean table to demonstrate results
	* Note: certain queries were updated to accomodate for missing columns (ex: PropertyAddress) for demonstration
*/

------------------------------------------------------------------------------------------------------------------------

/*1. STANDARDIZE SALEDATE FORMAT*/

--SaleDate column before--
SELECT SaleDate
FROM PortfolioProject..NashvilleHousing_Raw

--SaleDate column cleaning: Change the data type from DATETIME to DATE using ALTER COLUMN--
ALTER TABLE NashvilleHousing
ALTER COLUMN SaleDate DATE;

--SaleDate column after: JOIN raw & clean table to compare results
SELECT raw.SaleDate AS SaleDate_Before, clean.SaleDate AS SaleDate_After
FROM PortfolioProject..NashvilleHousing_Raw as raw
JOIN PortfolioProject..NashvilleHousing_Clean as clean
	ON raw.[UniqueID ] = clean.[UniqueID ]

 ------------------------------------------------------------------------------------------------------------------------

/*2. POPULATE PROPERTYADDRESS COLUMN WHERE DATA IS NULL*/

--PropertyAddress column before: ParcelID matches, but property address may be NULL or NOT NULL--
--Note: The AddressToReplaceNULL column shows which value will go into the NULL PropertyAddress value
SELECT a.ParcelID, a.PropertyAddress, b.ParcelID,
	b.PropertySplitAddress + ', ' + b.PropertySplitCity AS PropertyAddress,
	ISNULL(a.PropertyAddress,b.PropertySplitAddress + ', ' + b.PropertySplitCity) AS AddressToReplaceNULL
FROM PortfolioProject.dbo.NashvilleHousing_Raw a
JOIN PortfolioProject.dbo.NashvilleHousing_Clean b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL

--PropertyAddress column cleaning: Change NULL values to the address value from another row that shares the same ParcelID--
--Note: This query works because every ParcelID is unique and tied to one specific property address--
UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM PortfolioProject..NashvilleHousing_Clean AS a
JOIN PortfolioProject..NashvilleHousing_Clean AS b
	ON a.ParcelID = b.ParcelID AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL

--PropertyAddress column after: A blank table being returned confirms all NULL values were populated--
SELECT ParcelID, PropertySplitAddress + ', ' + PropertySplitCity AS PropertyAddress
FROM PortfolioProject..NashvilleHousing_Clean
WHERE PropertySplitAddress IS NULL or PropertySplitCity IS NULL

------------------------------------------------------------------------------------------------------------------------

/*3. PROPERTYADDRESS AND OWNERADDRESS PARSING*/

--PropertyAddress and OwnerAddress before: Single columns containing full addresses
SELECT PropertyAddress, OwnerAddress
FROM PortfolioProject..NashvilleHousing_Raw

--PropertyAddress and OwnerAddress cleaning: Add columns that will house parsed addresses to table--
ALTER TABLE NashvilleHousing
ADD PropertySplitAddress NVARCHAR(255);
ALTER TABLE NashvilleHousing
ADD PropertySplitCity NVARCHAR(255);
ALTER TABLE NashvilleHousing
ADD OwnerSplitAddress NVARCHAR(255);
ALTER TABLE NashvilleHousing
ADD OwnerSplitCity NVARCHAR(255);
ALTER TABLE NashvilleHousing
ADD OwnerSplitState NVARCHAR(255);

--PropertyAddress and OwnerAddress cleaning: Add parsed address substrings to the new columns in the table--
--Note: Substring function uses comma index location to help split address--
--Note: Parsename function splits address after replacing comma with period (delimiter must be '.' to work)--
UPDATE NashvilleHousing_Clean
SET PropertySplitAddress = SUBSTRING(PropertyAddress,1, CHARINDEX(',', PropertyAddress) - 1);
UPDATE NashvilleHousing_Clean
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) + 1, LEN(PropertyAddress));
UPDATE NashvilleHousing_Clean
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3);
UPDATE NashvilleHousing_Clean
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2);
UPDATE NashvilleHousing_Clean
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1);

--PropertyAddress and OwnerAddress after: Each address substring has been placed in their own columns--
SELECT PropertySplitAddress, PropertySplitCity, OwnerSplitAddress, OwnerSplitCity, OwnerSplitState
FROM PortfolioProject..NashvilleHousing_Clean

------------------------------------------------------------------------------------------------------------------------

/*4. SOLDASVACANT YES/NO STANDARDIZATION*/

--SoldAsVacant before: This column contains Y, N, Yes, and No values--
SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant) AS Count
FROM PortfolioProject..NashvilleHousing_Raw
GROUP BY SoldAsVacant
ORDER BY Count

--SoldAsVacant cleaning: Convert 'Y' to 'Yes' and 'N' to 'No'--
UPDATE NashvilleHousing_Clean
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
						WHEN SoldAsVacant = 'N' THEN 'No'
						ELSE SoldAsVacant END

--SoldAsVacant After: 'Yes' and 'No' values only--
SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant) AS Count
FROM PortfolioProject..NashvilleHousing_Clean
GROUP BY SoldAsVacant
ORDER BY Count

------------------------------------------------------------------------------------------------------------------------

/*5. REMOVE DUPLICATE ROWS*/
--Note: A row is considered a 'duplicate' if it has equal values as another row in certain columns--
--Columns to be checked: ParcelID, PropertyAddress, SaleDate, SalePrice, LegalReference--

--Remove duplicate rows before: Identify which rows to be deleted--
--Note: ROW_NUMBER function helps identify duplicates when partitioning. CTE used to allow filtering via WHERE/ORDER BY--
WITH RowNumCTE_Raw AS (
SELECT *, ROW_NUMBER() OVER(
	PARTITION BY ParcelID, PropertyAddress, SaleDate, SalePrice, LegalReference ORDER BY UniqueID) AS RowNum
FROM PortfolioProject..NashvilleHousing_Raw
)
SELECT *
FROM RowNumCTE_Raw
WHERE RowNum > 1
ORDER BY PropertyAddress

--Remove duplicate rows cleaning: Deletes duplicates--
--Note: Duplicates identified as a row WHERE RowNum > 1 thanks to ROW_NUMBER/Partitioning--
WITH RowNumCTE AS (
SELECT *, ROW_NUMBER() OVER(
	PARTITION BY ParcelID, PropertyAddress, SaleDate, SalePrice, LegalReference ORDER BY UniqueID) AS RowNum
FROM PortfolioProject..NashvilleHousing_Clean
)
DELETE
FROM RowNumCTE
WHERE RowNum > 1

--Remove duplicate rows after: A blank CTE confirms sucessful deletion of duplicates--
WITH RowNumCTE AS (
SELECT *, ROW_NUMBER() OVER(
	PARTITION BY ParcelID, PropertySplitAddress, PropertySplitCity, SaleDate, SalePrice, LegalReference ORDER BY UniqueID) AS RowNum
FROM PortfolioProject..NashvilleHousing_Clean
)
SELECT *
FROM RowNumCTE
WHERE RowNum > 1

------------------------------------------------------------------------------------------------------------------------

/*6. DELETE UNUSED COLUMNS*/

--Note: Dropping columns is not typically considered good practice. This is done here for demonstration only.--

--Drop columns before: see the entire table to find columns to remove--
Select *
From PortfolioProject..NashvilleHousing_Raw

--Drop columns cleaning: remove the columns identified as irrelevant--
ALTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP COLUMN PropertyAddress, OwnerAddress, TaxDistrict

--Drop columns after: see the table without the columns that were removed with the above statement--
SELECT *
FROM PortfolioProject..NashvilleHousing_Clean

------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

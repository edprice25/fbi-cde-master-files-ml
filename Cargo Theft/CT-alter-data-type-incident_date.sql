-- Step 1
ALTER TABLE Cargo_Theft.CT_NATIONAL_MASTER_FILE_incident_reports
RENAME COLUMN incident_date TO incident_date_to_drop;

-- Step 2
ALTER TABLE Cargo_Theft.CT_NATIONAL_MASTER_FILE_incident_reports
ADD COLUMN incident_date DATE;

-- Step 3
UPDATE Cargo_Theft.CT_NATIONAL_MASTER_FILE_incident_reports
SET incident_date = PARSE_DATE('%Y%m%d', CAST(incident_date_to_drop AS STRING))
WHERE incident_date_to_drop IS NOT NULL AND incident_date_to_drop != 0;

-- Step 4
ALTER TABLE Cargo_Theft.CT_NATIONAL_MASTER_FILE_incident_reports
DROP COLUMN incident_date_to_drop;

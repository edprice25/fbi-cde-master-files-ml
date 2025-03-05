-- Step 1
ALTER TABLE Cargo_Theft.CT_NATIONAL_MASTER_FILE_incident_reports
RENAME COLUMN recovered_date TO recovered_date_to_drop;

-- Step 2
ALTER TABLE Cargo_Theft.CT_NATIONAL_MASTER_FILE_incident_reports
ADD COLUMN recovered_date DATE;

-- Step 3
UPDATE Cargo_Theft.CT_NATIONAL_MASTER_FILE_incident_reports
SET recovered_date = PARSE_DATE('%Y%m%d', CAST(recovered_date_to_drop AS STRING))
WHERE recovered_date_to_drop IS NOT NULL AND recovered_date_to_drop != 0;

-- Step 4
ALTER TABLE Cargo_Theft.CT_NATIONAL_MASTER_FILE_incident_reports
DROP COLUMN recovered_date_to_drop;

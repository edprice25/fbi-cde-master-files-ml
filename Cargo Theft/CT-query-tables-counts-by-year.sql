-- ==============================================================================================
-- Validate the Batch Headers table has fixed number of records (25415) for each year (2020-2023)

SELECT count(0) FROM Cargo_Theft.CT_NATIONAL_MASTER_FILE_batch_headers;

SELECT count(0), master_file_year
FROM Cargo_Theft.CT_NATIONAL_MASTER_FILE_batch_headers
group by master_file_year
order by master_file_year;


-- ===========================================================================================
-- Validate the Incident Reports table has varying number of records for each year (2020-2023)

SELECT count(0) FROM Cargo_Theft.CT_NATIONAL_MASTER_FILE_incident_reports;

SELECT count(0), incident_date
FROM Cargo_Theft.CT_NATIONAL_MASTER_FILE_incident_reports
group by incident_date
order by incident_date;


-- ==========================================================================
-- Validate we can join the Batch Headers table to the Incident Reports table

-- Validate join fields are not null:
select count(0) from Cargo_Theft.CT_NATIONAL_MASTER_FILE_batch_headers where ori is null;
select count(0) from Cargo_Theft.CT_NATIONAL_MASTER_FILE_batch_headers where agency_name is null;
select count(0) from Cargo_Theft.CT_NATIONAL_MASTER_FILE_batch_headers where master_file_year is null;

-- Validate join fields are not null:
select count(0) from Cargo_Theft.CT_NATIONAL_MASTER_FILE_incident_reports where ori is null;
select count(0) from Cargo_Theft.CT_NATIONAL_MASTER_FILE_incident_reports where agency_name is null;
select count(0) from Cargo_Theft.CT_NATIONAL_MASTER_FILE_incident_reports where incident_date is null;


-- =========================================================================================================
-- LEFT (OUTER) JOIN: Returns all records from the left table, and the matched records from the right table.
--
-- Expect varying count_incident for each year (2020-2023)
--
SELECT
  bh.master_file_year,
  count(ir.incident_number) as count_incident
FROM
  Cargo_Theft.CT_NATIONAL_MASTER_FILE_incident_reports ir
LEFT JOIN
  Cargo_Theft.CT_NATIONAL_MASTER_FILE_batch_headers bh
  ON ir.ori = bh.ori AND ir.agency_name = bh.agency_name
  AND EXTRACT(YEAR FROM ir.incident_date) = bh.master_file_year
group by
  bh.master_file_year
order by
  bh.master_file_year;

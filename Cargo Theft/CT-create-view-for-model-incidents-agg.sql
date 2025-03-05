-- ==========================================
-- Create a View for training the ML model
--
-- RIGHT (OUTER) JOIN: Returns all records from the right table, and the matched records from the left table.
--
-- Expect fixed number of records (25415 * 4 years = 101660)
--
-- Expect varying current_population_1 for each year (since city populations usually change year-to-year)
-- Expect constant core_city for each join key (ori, agency_name, master_file_year/incident_date)
-- Expect constant state_abbrev for each join key (ori, agency_name, master_file_year/incident_date)
-- Expect varying count_incident for each join key (ori, agency_name, master_file_year/incident_date)
-- Expect varying average_stolen_value for each join key (ori, agency_name, master_file_year/incident_date)
--   Ignores outliers, for training the ML model
-- Expect varying sum_stolen_value for each join key (ori, agency_name, master_file_year/incident_date)
--   Ignores outliers, for training the ML model
--
CREATE OR REPLACE VIEW Cargo_Theft_Views.CT_VIEW_INCIDENTS_AGG AS
SELECT
  bh.ori,
  bh.agency_name,
  bh.master_file_year,
  bh.current_population_1,
  bh.core_city,
  lookup_sc.state_abbev as state_abbrev,
  COUNT(ir.incident_number) as count_incident,
  -- Ignore the few outliers with very high Stolen Value:
  ROUND(AVG(CASE
        WHEN ir.stolen_value BETWEEN 0 AND 499999.99 THEN ir.stolen_value
        ELSE NULL
      END),2) AS average_stolen_value,
  ROUND(SUM(CASE
        WHEN ir.stolen_value BETWEEN 0 AND 499999.99 THEN ir.stolen_value
        ELSE 0
      END),2) AS sum_stolen_value
FROM
  Cargo_Theft.CT_NATIONAL_MASTER_FILE_incident_reports ir
RIGHT JOIN
  Cargo_Theft.CT_NATIONAL_MASTER_FILE_batch_headers bh
  ON ir.ori = bh.ori AND ir.agency_name = bh.agency_name
  AND EXTRACT(YEAR FROM ir.incident_date) = bh.master_file_year
LEFT JOIN
  Cargo_Theft.US_STATES lookup_sc
  ON bh.state_code = lookup_sc.state_code
GROUP BY
  bh.ori,
  bh.agency_name,
  bh.master_file_year,
  bh.current_population_1,
  bh.core_city,
  state_abbrev
ORDER BY
  bh.ori,
  bh.agency_name,
  bh.master_file_year;

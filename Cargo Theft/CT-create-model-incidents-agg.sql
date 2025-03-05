-- Create the ML model and train it with data prior to 2023.
CREATE OR REPLACE MODEL
  Cargo_Theft_Models.CT_MODEL_INCIDENTS_AGG
OPTIONS
  (model_type='linear_reg', input_label_cols=['count_incident'])
AS
  SELECT
    ori,
    agency_name,
    master_file_year,
    current_population_1,
    core_city,
    state_abbrev,
    count_incident
  FROM
    Cargo_Theft_Views.CT_VIEW_INCIDENTS_AGG
  WHERE
    master_file_year < 2023
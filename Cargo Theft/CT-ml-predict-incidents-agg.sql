-- Use the ML model to test predictions with the 2023 data.
SELECT
  CAST(ROUND(predicted_count_incident) AS INT64) as round_predicted_count_incident,
  *
FROM
  ML.PREDICT(MODEL Cargo_Theft_Models.CT_MODEL_INCIDENTS_AGG,(
    SELECT
      count_incident, -- Want to predict
      ori,
      agency_name,
      master_file_year,
      current_population_1,
      core_city,
      state_abbrev
    FROM
      Cargo_Theft_Views.CT_VIEW_INCIDENTS_AGG
    WHERE
      master_file_year = 2023
    LIMIT 1000
  )
)

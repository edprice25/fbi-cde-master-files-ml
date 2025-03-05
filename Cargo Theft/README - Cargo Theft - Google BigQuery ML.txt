1. Use the 'fbi-cde-master-files-processor' repository to process the yearly FBI master raw data files.

2. Import the union processed files into Google BigQuery tables.
  Cargo_Theft.CT_NATIONAL_MASTER_FILE_batch_headers
  Cargo_Theft.CT_NATIONAL_MASTER_FILE_incident_reports

3. Alter data types for DATE columns.
  CT-alter-data-type-incident_date.sql
  CT-alter-data-type-recovered_date.sql

4. Import the US state and territory codes into Google BigQuery table.
  Cargo_Theft.US_STATES

5. Import the Cargo Theft specific offense codes into Google BigQuery table.
  Cargo_Theft.CT_OFFENSES

6. Validate the data was successfully imported.
  CT-query-tables-counts-by-year.sql

7. Create a View for training the ML model.
  CT-create-view-for-model-incidents-agg.sql

8. Create the ML model and train it with data prior to 2023.
  CT-create-model-incidents-agg.sql

9. Use the ML model to predict the 2023 data.
  CT-ml-predict-incidents-agg.sql

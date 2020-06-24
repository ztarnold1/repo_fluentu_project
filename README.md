This is for the trial project with FluentU.

I created an initial dataset in Google BigQuery titled "stack_overflow_project", which is the source for the dbt project.
The dbt dataset is titled dbt_prod, which transforms the data from the "stack_overflow_project" and creates dim tables and one fact table for use in a viz tool.
Additional information about each table and transformations can be found in the respective schema files and sql files.

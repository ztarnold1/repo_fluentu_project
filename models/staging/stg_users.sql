SELECT 
user_id,
display_name,
about_me, 
age, 
creation_date, 
last_access_date, 
location, 
reputation, 
up_votes, 
views
FROM {{ source('stack_overflow_project','users')}}
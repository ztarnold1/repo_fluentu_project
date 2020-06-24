/*I am filtering to only users who have accessed the site since 05/01/2020, which is the filter I've placed on the posts.
*/

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
where date(last_access_date) >= date('2020-05-01')
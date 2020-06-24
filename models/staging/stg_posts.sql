/*This script joins together the answers and questions table into one posts table. I convert several of the fields to INT because those fields should be INT, and to make
sure both selects are using the same datatypes in order to UNION. I am setting nulls to 0 on several of the counts, because they will be used in later logic*/

SELECT 
post_id, 
CAST(accepted_answer_id AS INT64) as accepted_answer_id, 
IFNULL(CAST(answer_count AS INT64),0) as answer_count, 
comment_count, 
creation_date, 
CAST(favorite_count AS INT64) as favorite_count, 
last_activity_date, 
last_edit_date, 
last_editor_user_id, 
owner_user_id, 
parent_id, 
post_type_id,
IFNULL(score,0) AS score,
IFNULL(CAST(view_count as INT64),0) as view_count
FROM {{ source('stack_overflow_project', 'posts_answers') }}
UNION ALL
SELECT 
post_id, 
accepted_answer_id, 
IFNULL(answer_count,0) AS answer_count, 
comment_count, 
creation_date, 
favorite_count, 
last_activity_date, 
last_edit_date, 
last_editor_user_id, 
owner_user_id, 
CAST(parent_id AS INT64) as parent_id, 
post_type_id,
IFNULL(score,0) AS score, 
IFNULL(view_count,0) AS view_count
FROM {{ source('stack_overflow_project', 'posts_questions') }}
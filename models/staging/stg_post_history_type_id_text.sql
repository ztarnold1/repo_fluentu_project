/*The purpose of this table is to provide text that makes further code more clear. 
Only the types listed will be relevant in the filter used to choose the posts that should be considered for analysis
*/
SELECT
DISTINCT post_history_type_id,
case when post_history_type_id = 10
then 'Closed'
when post_history_type_id = 11
then 'Reopened'
when post_history_type_id = 12
then 'Deleted'
when post_history_type_id = 13
then 'Undeleted'
when post_history_type_id = 14
then 'Locked'
when post_history_type_id = 15
then 'Unlocked'
Else 'NA'
End as post_history_type_text 

 from {{ref('stg_post_history')}} where post_history_type_id between 10 and 15
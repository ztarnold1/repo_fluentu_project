/*this table will be a bridge table between the users table and the posts_tags table, so that I can filter the set of posts based on a given user's (expert's) set of badges  */
select 
distinct
name as badge_name,
 from {{ source('stack_overflow_project', 'badges') }}
 where tag_based = true
 AND class = 1
 AND date(date) >= DATE('2018-01-01')
 order by 1
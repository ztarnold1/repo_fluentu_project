select 
badge_id,
name as badge_name,
date,
user_id,
class,
tag_based
 from {{ source('stack_overflow_project', 'badges') }}
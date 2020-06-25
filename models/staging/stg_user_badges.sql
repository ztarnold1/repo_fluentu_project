/*I will be using the badges table to determine "experts" that should be answering these unanswered, popular questions.
I'm defining expert as a user who was awarded a Gold level badge (class = 1) in the last ~two years (beginning of 2018 to current) in the respective badge area. 
I only care about badges that are tag based (tag based = true), because I will use the tag based badges as a filter for which questions the respective expert should answer.
*/

select 
badge_id,
name as badge_name,
date,
user_id,
class,
tag_based
 from {{ source('stack_overflow_project', 'badges') }}
 where tag_based = true
 AND class = 1
 AND date(date) >= DATE('2018-01-01')
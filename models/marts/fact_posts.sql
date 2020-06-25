/*For unanswered questions (answer count = 0), we only care about questions that are Open, and that are popular/trending. 
Questions that aren't open are being filtered out by the lookup to the stg_post_history and stg_post_history_type_id_text table.
Popular/trending is defined by me as having an view count >= 10 AND a score of >= 1. I've changed the score from 5 to 1 because I felt
5 was too restrictive, considering I saw several popular posts (~8k views) with only 2 upvotes.
*/

with history_type as (
    select post_history_type_id, post_history_type_text from {{ref('stg_post_history_type_id_text')}}
    ),

open_and_closed_posts as (
    select post_id,
/*this script loops through the post_history_type_text table to determine if a post is Closed, Deleted, or Locked. If so, we don't care about those posts for unanswered questions.
if the Closed, Deleted, or Locked flag sum is greater than Reopened, Undeleted, or Unlocked Flag, then exclude that record. The exclusion will happen in open_posts */ 
    {% for post_history_type_text in ["Closed","Reopened","Deleted","Undeleted","Locked","Unlocked"] %}
    SUM(case when post_history_type_text = '{{post_history_type_text}}' then 1 else 0 end) as {{post_history_type_text}}_flag
    {% if not loop.last %} , {% endif %}
    {% endfor %}
    from {{ref('stg_post_history')}} as post_history
    left join history_type on post_history.post_history_type_id = history_type.post_history_type_id
    group by post_id
    order by post_id
    ),

open_posts as (
    select
    post_id
    from open_and_closed_posts
    where Reopened_flag >= Closed_flag
    AND Undeleted_flag >= Deleted_flag
    AND Unlocked_flag >= Locked_flag
    ),

popular_unanswered_questions as (
    select * from {{ref('stg_posts')}} 
    inner join open_posts using (post_id)
    where answer_count = 0 
    AND post_type_id = 1 --this means it was a question
    AND (view_count >= 20 AND score >= 1) -- this is a popular question

    ),

answered_questions_and_answers as (
    select * from {{ref('stg_posts')}} 
    where 
    answer_count > 0 OR post_type_id = 2 --this is an answered question or an answer
    ),

 final as (
     select * from popular_unanswered_questions
     UNION ALL
     select * from answered_questions_and_answers
 )   

select * from final
order by 1

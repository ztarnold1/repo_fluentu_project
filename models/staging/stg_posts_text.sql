/*This script joins together the answers and questions texts table into one posts text table.*/
SELECT 
post_id, 
title as post_title, 
body as post_body, 
tags,
IFNULL((length(tags) - length(replace(tags,'|','')) + 1),0) as number_of_tags
 FROM {{ source('stack_overflow_project', 'posts_answers_text') }}
 UNION ALL
SELECT 
post_id, 
title as post_title, 
body as post_body, 
tags,
IFNULL((length(tags) - length(replace(tags,'|','')) + 1),0) as number_of_tags
 FROM {{ source('stack_overflow_project', 'posts_questions_text') }} 
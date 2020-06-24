SELECT comment_id, creation_date, post_id, user_id, score from {{ source('stack_overflow_project', 'comments') }}

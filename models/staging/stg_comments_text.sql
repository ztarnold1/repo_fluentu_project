SELECT comment_id, text as comment_text from {{ source('stack_overflow_project', 'comments_text') }}


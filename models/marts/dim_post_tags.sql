/*the purpose of this table is to have all tags associated with a post_id to have their own row.*/

with split_view as (select post_id, tags, split(tags, '|') as split_tags1 from {{ref('stg_posts_text')}})

select CONCAT(post_id, concat('_',split_tags)) as unique_id, post_id, split_tags from split_view
CROSS JOIN UNNEST(split_view.split_tags1) AS split_tags order by 1
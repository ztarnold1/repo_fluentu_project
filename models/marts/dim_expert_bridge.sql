/*this table will be a bridge table between my post tags table and the user badges table. this way, I can join a many to many relationship in order to filter the 
questions to the set of questions that a given expert should see.*/

with tags_view as (select unique_id, split_tags from {{ref('dim_post_tags')}}),

user_badges as (select badge_id, user_id, badge_name from {{ref('dim_user_badges')}}),

final as (
  select
  tags_view.unique_id,
  user_badges.badge_id,
--  user_badges.user_id
  from tags_view
  full outer join user_badges on tags_view.split_tags = user_badges.badge_name
   )

   select * from final
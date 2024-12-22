json.user_name post.user.profile.name if post.user&.profile
json.extract! post, :user_id, :title, :content, :tag, :post_image
json.url api_v1_post_url(post)
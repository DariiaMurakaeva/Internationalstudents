json.user_name @post.user.profile.name if @post.user&.profile
json.extract! @post, :title, :content, :tag, :post_image

json.set! :comments do
    json.array! @post.comments, partial: "api/v1/comments/comment", as: :comment
end
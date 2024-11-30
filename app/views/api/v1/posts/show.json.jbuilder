json.extract! @post, :user_id, :title, :content, :tags, :post_image, :created_at, :updated_at

json.set! :comments do
    json.array! @post.comments, partial: "api/v1/comments/comment", as: :comment
end
json.extract! @discussion, :user_id, :title, :content, :tags, :created_at, :updated_at

json.set! :comments do
    json.array! @discussion.comments, partial: "api/v1/comments/comment", as: :comment
end
json.user_name @discussion.user.profile.name if @discussion.user&.profile
json.extract! @discussion, :title, :content, :tag

json.set! :comments do
    json.array! @discussion.comments, partial: "api/v1/comments/comment", as: :comment
end
json.extract! discussion, :id, :name, :user_id, :title, :content, :tags, :created_at, :updated_at
json.url discussion_url(discussion, format: :json)

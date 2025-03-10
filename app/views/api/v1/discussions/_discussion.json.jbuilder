json.user_name discussion.user.profile.name if discussion.user&.profile
json.extract! discussion, :title, :content, :tag
json.url api_v1_discussion_url(discussion)

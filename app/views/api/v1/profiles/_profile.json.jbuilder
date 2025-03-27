json.extract! profile, :first_name, :last_name, :date_of_birth, :faculty, :country, :languages, :program_type, :profile_photo, :created_at, :updated_at
json.profile_photo_url profile.profile_photo_url
json.email profile.user.email 
json.url api_v1_profile_url(profile, format: :json)
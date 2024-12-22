json.extract! profile, :id, :user_id, :name, :date_of_birth, :faculty, :country, :languages, :program_type, :gender, :created_at, :updated_at
json.url api_v1_profile_url(profile, format: :json)
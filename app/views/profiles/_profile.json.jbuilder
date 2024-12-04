json.extract! profile, :id, :name, :date_of_birth, :faculty, :country, :languages, :program_type, :created_at, :updated_at
json.url profile_url(profile, format: :json)

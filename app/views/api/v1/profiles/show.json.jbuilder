json.id profile.id
json.first_name profile.first_name
json.last_name profile.last_name
json.date_of_birth profile.date_of_birth
json.faculty profile.faculty
json.country profile.country
json.languages profile.languages
json.program_type profile.program_type
json.email profile.user.email 

if profile.profile_photo.attached?
  json.profile_photo_url url_for(profile.profile_photo)
else
  json.profile_photo_url nil
end



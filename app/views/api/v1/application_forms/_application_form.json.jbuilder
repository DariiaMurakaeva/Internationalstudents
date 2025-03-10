json.student_name application_form.student.profile.name if application_form.student&.profile
json.extract! application_form, :about, :date_of_arrival, :time_of_arrival,
             :place_of_arrival, :student_id, :buddy_id,
             :created_at, :updated_at

json.buddy_name application_form.buddy.profile.name if application_form.buddy&.profile


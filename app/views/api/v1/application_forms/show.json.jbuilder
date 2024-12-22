json.id @application_form.id
json.about @application_form.about

# Debugging output
json.set! :debug do
  json.student @application_form.student
  json.student_name @application_form.student&.profile&.name
  json.buddy @application_form.buddy
  json.buddy_name @application_form.buddy&.profile&.name
end
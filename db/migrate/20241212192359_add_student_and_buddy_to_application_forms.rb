class AddStudentAndBuddyToApplicationForms < ActiveRecord::Migration[7.2]
  def change
    add_column :application_forms, :student_id, :integer
    add_column :application_forms, :buddy_id, :integer
  end
end

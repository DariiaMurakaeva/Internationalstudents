class RemoveUserIdFromApplicationForms < ActiveRecord::Migration[7.2]
  def change
    remove_column :application_forms, :user_id
  end
end

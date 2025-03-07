class RemoveNoteFromApplicationForms < ActiveRecord::Migration[7.2]
  def change
    remove_column :application_forms, :note, :text
    remove_column :application_forms, :place_of_residence, :string
  end
end

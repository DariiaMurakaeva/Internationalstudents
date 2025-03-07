class RemoveGenderFromProfiles < ActiveRecord::Migration[7.2]
  def change
    remove_column :profiles, :gender, :string
    remove_column :profiles, :name, :string

    add_column :profiles, :first_name, :string
    add_column :profiles, :last_name, :string
  end
end

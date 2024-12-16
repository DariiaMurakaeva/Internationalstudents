class AddGenderToProfiles < ActiveRecord::Migration[7.2]
  def change
    add_column :profiles, :gender, :string
  end
end

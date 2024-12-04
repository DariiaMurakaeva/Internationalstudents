class CreateProfiles < ActiveRecord::Migration[7.2]
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :name
      t.date :date_of_birth
      t.string :faculty
      t.string :country
      t.string :languages
      t.string :program_type

      t.timestamps
    end
  end
end

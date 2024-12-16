class CreateApplicationForms < ActiveRecord::Migration[7.2]
  def change
    create_table :application_forms do |t|
      t.references :user, null: false, foreign_key: true
      t.text :about
      t.date :date_of_arrival
      t.time :time_of_arrival
      t.string :place_of_arrival
      t.string :place_of_residence
      t.text :note

      t.timestamps
    end
  end
end

class CreateBookmarks < ActiveRecord::Migration[7.2]
  def change
    create_table :bookmarks do |t|
      t.references :user, null: false, foreign_key: true
      t.string :bookmarkable_type
      t.integer :bookmarkable_id

      t.timestamps
    end
  end
end

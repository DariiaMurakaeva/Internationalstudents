class CreateDiscussions < ActiveRecord::Migration[7.2]
  def change
    create_table :discussions do |t|
      t.string :author
      t.integer :user_id
      t.string :title
      t.text :content
      t.string :tags

      t.timestamps
    end
  end
end

class AddTagsToPost < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :tags, :string
  end
end

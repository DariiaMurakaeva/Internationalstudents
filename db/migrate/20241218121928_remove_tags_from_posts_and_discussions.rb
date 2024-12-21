class RemoveTagsFromPostsAndDiscussions < ActiveRecord::Migration[7.2]
  def change
    remove_column :posts, :tags, :string
    remove_column :discussions, :tags, :string
  end
end

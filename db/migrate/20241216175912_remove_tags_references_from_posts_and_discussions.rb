class RemoveTagsReferencesFromPostsAndDiscussions < ActiveRecord::Migration[7.2]
  def change
    if foreign_key_exists?(:posts, :tags)
      remove_foreign_key :posts, :tags
    end
  end
end

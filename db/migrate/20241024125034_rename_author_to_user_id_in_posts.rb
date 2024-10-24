class RenameAuthorToUserIdInPosts < ActiveRecord::Migration[7.2]
  def change
    rename_column :posts, :author, :user_id
    change_column :posts, :user_id, :integer
  end
end

class RemoveUserFromPosts < ActiveRecord::Migration[7.2]
  def change
    remove_column :posts, :user, :string
  end
end

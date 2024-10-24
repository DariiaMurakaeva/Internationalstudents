class RenameAuthorToUseridInComments < ActiveRecord::Migration[7.2]
  def change
    rename_column :comments, :author, :user_id
    change_column :comments, :user_id, :integer
  end
end

class AddDiscussionIdToComments < ActiveRecord::Migration[7.2]
  def change
    add_column :comments, :discussion_id, :integer
  end
end

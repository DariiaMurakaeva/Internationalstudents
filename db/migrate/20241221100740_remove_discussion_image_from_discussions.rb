class RemoveDiscussionImageFromDiscussions < ActiveRecord::Migration[7.2]
  def change
    remove_column :discussions, :discussion_image, :string
  end
end

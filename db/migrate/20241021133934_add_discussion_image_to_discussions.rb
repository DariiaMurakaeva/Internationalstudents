class AddDiscussionImageToDiscussions < ActiveRecord::Migration[7.2]
  def change
    add_column :discussions, :discussion_image, :string
  end
end

class AddTagToDiscussions < ActiveRecord::Migration[7.2]
  def change
    add_column :discussions, :tag, :string
  end
end

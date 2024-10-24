class RemoveAuthorFromDiscussions < ActiveRecord::Migration[7.2]
  def change
    remove_column :discussions, :author, :string
  end
end

class AddCommentableColumnsToComments < ActiveRecord::Migration[7.2]
  def change

    remove_column :comments, :post_id, :integer
    remove_column :comments, :discussion_id, :integer

    add_column :comments, :commentable_id, :integer
    add_column :comments, :commentable_type, :string
  end
end

class AddTagToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :tag, :string
  end
end

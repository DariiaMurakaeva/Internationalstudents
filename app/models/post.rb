class Post < ApplicationRecord
    validates :title, :presence => true, :length => { :minimum => 5 }

    belongs_to :user
    # has_many :comments, :dependent => :destroy
    has_many :comments, as: :commentable
    has_many :bookmarks, as: :bookmarkable

    mount_uploader :post_image, PostImageUploader

    default_scope { order(created_at: "DESC")}
end

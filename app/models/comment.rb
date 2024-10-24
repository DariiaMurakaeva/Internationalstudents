class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  # belongs_to :post, optional: true
  # belongs_to :discussion, optional: true
end
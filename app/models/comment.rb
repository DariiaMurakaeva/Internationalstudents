class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :discussion
end
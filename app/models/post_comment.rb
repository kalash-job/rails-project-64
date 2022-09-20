# frozen_string_literal: true

class PostComment < ApplicationRecord
  belongs_to :creator, class_name: 'User', inverse_of: 'comments', foreign_key: 'user_id'
  belongs_to :post, inverse_of: 'comments', foreign_key: 'post_id'
  has_ancestry

  validates :content, presence: true
end

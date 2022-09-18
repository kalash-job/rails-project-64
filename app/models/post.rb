# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :category, inverse_of: 'posts'
  belongs_to :creator, class_name: 'User', inverse_of: 'posts', foreign_key: 'user_id'

  validates :title, presence: true
  validates :body, length: { maximum: 1000, minimum: 50 }

  scope :ordered, -> { Post.order(created_at: :desc) }
end

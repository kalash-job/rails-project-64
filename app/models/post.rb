# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  body        :text
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer          not null
#  creator_id  :integer          not null
#
# Indexes
#
#  index_posts_on_category_id  (category_id)
#  index_posts_on_creator_id   (creator_id)
#
# Foreign Keys
#
#  category_id  (category_id => categories.id)
#  creator_id   (creator_id => users.id)
#
class Post < ApplicationRecord
  belongs_to :category, inverse_of: :posts
  belongs_to :creator, class_name: 'User', inverse_of: :posts
  has_many :comments, class_name: 'PostComment', inverse_of: :post, dependent: :destroy

  validates :body, :title, presence: true
  validates :body, length: { in: 200..4000 }, allow_blank: true
  validates :title, length: { in: 5..255 }, allow_blank: true

  scope :by_creation_date_desc, -> { order(created_at: :desc) }
end

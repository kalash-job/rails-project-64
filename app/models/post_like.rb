# frozen_string_literal: true

# == Schema Information
#
# Table name: post_likes
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_post_likes_on_post_id              (post_id)
#  index_post_likes_on_post_id_and_user_id  (post_id,user_id) UNIQUE
#  index_post_likes_on_user_id              (user_id)
#
# Foreign Keys
#
#  post_id  (post_id => posts.id)
#  user_id  (user_id => users.id)
#
class PostLike < ApplicationRecord
  belongs_to :post, inverse_of: :likes
  belongs_to :user, inverse_of: :likes

  validates :post_id, uniqueness: { scope: :user_id }

  scope :likes_by_post, ->(post_id) { where(post_id:) }
  scope :likes_by_user, ->(user_id) { where(user_id:) }
end
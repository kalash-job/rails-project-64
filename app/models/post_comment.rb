# frozen_string_literal: true

# == Schema Information
#
# Table name: post_comments
#
#  id         :integer          not null, primary key
#  ancestry   :string
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_post_comments_on_ancestry  (ancestry)
#  index_post_comments_on_post_id   (post_id)
#  index_post_comments_on_user_id   (user_id)
#
# Foreign Keys
#
#  post_id  (post_id => posts.id)
#  user_id  (user_id => users.id)
#
class PostComment < ApplicationRecord
  has_ancestry
  belongs_to :post, class_name: 'Post', inverse_of: :comments
  belongs_to :user, inverse_of: :comments

  validates :content, length: { in: 5..400 }, allow_blank: true
  validates :content, presence: true

  scope :by_creation_date_desc, -> { order(created_at: :desc) }
  scope :root_comments, -> { where(ancestry: nil) }
  scope :comments_by_post, ->(post_id) { where(post_id:) }
  scope :comments_subtree, ->(comment) { comment.subtree.arrange(order: { created_at: :desc }) }
end
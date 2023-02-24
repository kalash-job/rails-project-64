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
#  creator_id :integer          not null
#  post_id    :integer          not null
#
# Indexes
#
#  index_post_comments_on_ancestry    (ancestry)
#  index_post_comments_on_creator_id  (creator_id)
#  index_post_comments_on_post_id     (post_id)
#
# Foreign Keys
#
#  creator_id  (creator_id => users.id)
#  post_id     (post_id => posts.id)
#
class PostComment < ApplicationRecord
  has_ancestry
  belongs_to :post, class_name: 'Post', inverse_of: :comments
  belongs_to :creator, class_name: 'User', inverse_of: :comments

  validates :content, length: { in: 5..400 }, allow_blank: true
  validates :content, presence: true

  scope :by_creation_date_desc, -> { order(created_at: :desc) }
  scope :root_comments, -> { where(ancestry: nil) }
  scope :comments_by_post, ->(post_id) { where(post_id:) }
  scope :comments_subtree, ->(comment) { comment.subtree.arrange(order: { created_at: :desc }) }
end

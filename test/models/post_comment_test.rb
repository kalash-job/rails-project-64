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
require 'test_helper'

class PostCommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

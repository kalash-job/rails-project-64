# frozen_string_literal: true

require 'test_helper'

class Web::Posts::CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @parent_comment = post_comments(:nested)
    content = Faker::Lorem.paragraph_by_chars(number: 180)
    @attrs = {
      content:,
      parent_id: @parent_comment.id
    }
    @searching_attrs = {
      content:,
      user_id: users(:one).id,
      ancestry: "#{post_comments(:with_comments).id}/#{@parent_comment.id}",
      post_id: @post.id
    }
  end

  test 'should create comment' do
    sign_in users(:one)
    post post_comments_url(@post), params: { post_comment: @attrs }
    comment = PostComment.find_by(@searching_attrs)

    assert { comment }
    assert_redirected_to post_url(@post)
  end

  test 'should not create comment without login' do
    post post_comments_url(@post), params: { post_comment: @attrs }
    comment = PostComment.find_by(@searching_attrs)

    assert { comment.nil? }
    assert_redirected_to new_user_session_path
  end
end

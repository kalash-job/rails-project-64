# frozen_string_literal: true

require 'test_helper'

class Web::LikesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @post = posts(:two)
    @user = users(:one)
  end

  test 'should create like' do
    sign_in @user
    post post_like_url(@post)
    like = PostLike.likes_by_post(@post.id).likes_by_user(@user.id).first

    assert { like }
    assert_redirected_to post_path(@post)
  end

  test 'should not create like without login' do
    post post_like_url(@post)
    like = PostLike.likes_by_post(@post.id).likes_by_user(@user.id).first

    assert { like.nil? }
    assert_redirected_to new_user_session_path
  end

  test 'should destroy like' do
    sign_in @user
    like = post_likes(:one)
    deleted_like_id = like.id
    delete post_like_url(like.post)

    assert_redirected_to post_path(like.post)
    assert { PostLike.find_by(id: deleted_like_id).nil? }
  end

  test 'should not destroy like without login' do
    like = post_likes(:one)
    deleted_like_id = like.id
    delete post_like_url(like.post)

    assert_redirected_to new_user_session_path
    assert { PostLike.find_by(id: deleted_like_id).present? }
  end
end

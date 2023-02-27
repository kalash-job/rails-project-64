# frozen_string_literal: true

require 'test_helper'

class Web::PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @post = posts(:one)
    @attrs = {
      title: Faker::Lorem.paragraph_by_chars(number: 180),
      body: Faker::Lorem.paragraph_by_chars(number: 1000),
      category_id: categories(:one).id
    }
  end

  test 'should get index' do
    get root_url
    assert_response :success
  end

  test 'should get new' do
    sign_in users(:one)
    get new_post_url
    assert_response :success
  end

  test 'should not get new without login' do
    get new_post_url
    assert_redirected_to new_user_session_path
  end

  test 'should create post' do
    sign_in users(:one)
    post posts_url, params: { post: @attrs }
    post = Post.find_by(@attrs)

    assert { post }
    assert_redirected_to root_url
  end

  test 'should not create post without login' do
    post posts_url, params: { post: @attrs }

    post = Post.find_by(@attrs)

    assert { post.nil? }
    assert_redirected_to new_user_session_path
  end

  test 'should show post' do
    get post_url(@post)
    assert_response :success
  end
end

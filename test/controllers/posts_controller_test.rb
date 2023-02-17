# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @post = posts(:one)
  end

  test 'should get index' do
    get root_url
    assert_response :success
  end

  test 'should get new' do
    get new_post_url
    assert_response :success
  end

  test 'should create post' do
    @attrs = {
      title: Faker::Lorem.paragraph_by_chars(number: 180),
      body: Faker::Lorem.paragraph_by_chars(number: 1000),
      category_id: categories(:one).id
    }
    sign_in users(:one)
    post posts_url, params: { post: @attrs }

    post = Post.find_by(@attrs)
    assert { post }

    assert_redirected_to root_url
  end

  test 'should show post' do
    get post_url(@post)
    assert_response :success
  end
end

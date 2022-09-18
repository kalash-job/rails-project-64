# frozen_string_literal: true

require 'test_helper'

class Web::PostsControllerTest < ActionDispatch::IntegrationTest
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
      title: Faker::Lorem.sentence,
      body: Faker::Lorem.sentences.join(' '),
      category_id: Category.create(name: Faker::Name.name).id
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

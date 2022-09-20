# frozen_string_literal: true

CATEGORIES = %w[js php python ruby c#].freeze

CATEGORIES.each do |c|
  category = Category.create(name: c)
  Rails.logger.debug { "Add category #{category.name}" }
end

10.times do |_index|
  password = Faker::Internet.password
  user = User.new(email: Faker::Internet.unique.email, password: password, password_confirmation: password)
  user.save!
end

20.times do |index|
  post = Post.new(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.sentences(number: 10).join(' ')
  )
  user = User.all.sample
  post.creator = user
  category = Category.all.sample
  post.category = category
  post.save!
  Rails.logger.debug { "Add post number #{index + 1} - #{post.title}" }
end

20.times do |index|
  post = Post.all.sample
  parent_comment = post.comments.sample
  comment_params = { content: Faker::Lorem.sentences(number: 2).join(' '), parent: parent_comment }
  comment = post.comments.build(comment_params)
  user = User.all.sample
  comment.creator = user
  comment.save!
end

# frozen_string_literal: true

%w[Python Ruby JavaScript PHP].each do |category_name|
  category = Category.create(name: category_name)
  Rails.logger.debug { "Added category #{category.name}" }
end

10.times do
  password = Faker::Internet.password
  User.create(email: Faker::Internet.unique.email, password:, password_confirmation: password)
end

60.times do |index|
  delimiter = %W[\n\n \n].fetch(index.even? ? 0 : 1, ' ')
  post = Post.new(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraphs(number: 17).join(delimiter)
  )
  post.creator = User.all.sample
  post.category = Category.all.sample
  post.save!
  Rails.logger.debug { "Add post number #{index + 1} - #{post.title}" }
end

def create_comment(post, user, parent_comment)
  comment_params = { content: Faker::Lorem.paragraph_by_chars(number: 190), parent: parent_comment, user: }
  comment = post.comments.build(comment_params)
  comment.save!
end

10.times do
  post = Post.all.sample
  user = User.all.sample
  parent_comment = nil
  create_comment(post, user, parent_comment)
end

20.times do
  post = Post.all.sample
  parent_comment = post.comments.sample
  user = User.all.sample
  create_comment(post, user, parent_comment)
end

80.times do |_index|
  post = Post.all.sample
  parent_comment = post.comments.filter { |c| !c.parent.nil? }.sample
  user = User.all.sample
  create_comment(post, user, parent_comment)
end

80.times do |_index|
  post_id = Post.all.sample.id
  user = User.all.sample
  user.likes.create(post_id:)
end

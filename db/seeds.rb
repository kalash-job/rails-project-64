# frozen_string_literal: true

%w[Python Ruby JavaScript PHP].each do |category_name|
  category = Category.create(name: category_name)
  Rails.logger.debug { "Added category #{category.name}" }
end

10.times do
  password = Faker::Internet.password
  User.create(email: Faker::Internet.unique.email, password:, password_confirmation: password)
end

20.times do |index|
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

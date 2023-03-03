class ResetAllPostCacheCounters < ActiveRecord::Migration[7.0]
  def change
    Post.all.each do |post|
      Post.reset_counters(post.id, :comments_count, :likes_count)
    end
  end
end

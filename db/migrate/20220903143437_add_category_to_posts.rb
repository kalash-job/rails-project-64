class AddCategoryToPosts < ActiveRecord::Migration[6.1]
  def change
    add_reference :posts, :category, null: false, index: true, foreign_key: true
  end
end

class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.references :category, null: false, foreign_key: true, index: true
      t.references :creator, null: false, foreign_key: { to_table: :users }, index: true

      t.timestamps
    end
  end
end

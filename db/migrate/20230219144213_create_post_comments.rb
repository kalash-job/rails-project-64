class CreatePostComments < ActiveRecord::Migration[7.0]
  def change
    create_table :post_comments do |t|
      t.text :content
      t.references :post, null: false, foreign_key: true, index: true
      t.references :creator, null: false, foreign_key: { to_table: :users }, index: true

      t.timestamps
    end
  end
end

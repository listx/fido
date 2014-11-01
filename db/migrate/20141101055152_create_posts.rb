class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :author
      t.string :title
      t.text :body
      t.boolean :published

      t.timestamps
    end
  end
end

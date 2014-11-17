class AddIndicesToPosts < ActiveRecord::Migration
  def change
    add_index :posts, :tenant_oid
    add_index :posts, :published, where: "published = true"
  end
end

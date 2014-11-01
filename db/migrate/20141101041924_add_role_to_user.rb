class AddRoleToUser < ActiveRecord::Migration
  def change
    add_column :users, :role_id, :integer, default: ROLE_AUTHOR
  end
end

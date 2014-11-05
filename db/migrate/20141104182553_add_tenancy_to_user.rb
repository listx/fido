class AddTenancyToUser < ActiveRecord::Migration
  def change
    add_column :users, :tenant_id, :integer, default: 1
  end
end

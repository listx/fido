class ChangeRolesDescription < ActiveRecord::Migration
  def change
    change_column :roles, :description, :string
  end
end

class CreateTenants < ActiveRecord::Migration
  def change
    create_table :tenants do |t|
      t.string :name
      t.integer :admin_id

      t.timestamps
    end
  end
end

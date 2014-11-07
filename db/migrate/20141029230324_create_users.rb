class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.integer :role_id, default: ROLE_AUTHOR
      t.integer :tenant_id

      t.timestamps
    end
  end
end

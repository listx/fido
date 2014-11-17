class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.integer :role_id, default: ROLE_AUTHOR
      t.binary :tenant_oid

      t.timestamps
    end
  end
end

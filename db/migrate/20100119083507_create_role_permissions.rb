class CreateRolePermissions < ActiveRecord::Migration[6.0]
  def self.up
    create_table :role_permissions do |t|
      t.integer :role_id, :permission_id
    end
  end

  def self.down
    drop_table :role_permissions
  end
end

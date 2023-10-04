class CreateUserRoles < ActiveRecord::Migration[6.0]
  def self.up
    create_table :user_roles do |t|
      t.integer :role_id
      t.integer :user_id
    end
  end

  def self.down
    drop_table :user_roles
  end
end

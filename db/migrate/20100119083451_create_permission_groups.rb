class CreatePermissionGroups < ActiveRecord::Migration[6.0]
  def self.up
    create_table :permission_groups do |t|
      t.string :name
    end
  end

  def self.down
    drop_table :permission_groups
  end
end

class CreatePermissions < ActiveRecord::Migration[6.0]
  def self.up
    create_table :permissions do |t|
      t.integer :parent_id, :permission_group_id
      t.string :name
      t.string :mapping
    end
  end

  def self.down
    drop_table :permissions
  end
end

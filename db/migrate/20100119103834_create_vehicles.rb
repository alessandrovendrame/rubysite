class CreateVehicles < ActiveRecord::Migration[6.0]
  def self.up
    create_table :vehicles do |t|
      t.string :name
      t.boolean :sender, :default => false
      t.boolean :recipient, :default => false
      t.boolean :carrier, :default => false
      t.boolean :vendor, :default => false
      
      t.boolean :register_a, :default => false
      t.boolean :register_b, :default => false
      t.boolean :register_c, :default => false
      t.boolean :register_d, :default => false
      t.boolean :register_e, :default => false
    end
  end

  def self.down
    drop_table :vehicles
  end
end

class CreateRegisterE < ActiveRecord::Migration[6.0]
  def self.up
    create_table :register_es do |t|
      t.string :code, :plate_number, :container
      t.decimal :gross, :precision => 12, :scale => 2, :default => 0
      t.decimal :nole_cost, :precision => 12, :scale => 2, :default => 0
      t.decimal :bl_cost, :precision => 12, :scale => 2, :default => 0
      t.decimal :transport_cost, :precision => 12, :scale => 2, :default => 0
      t.decimal :stop_cost, :precision => 12, :scale => 2, :default => 0
      t.decimal :incidental_cost, :precision => 12, :scale => 2, :default => 0
      t.decimal :net, :precision => 12, :scale => 2, :default => 0
      t.decimal :weight, :precision => 12, :scale => 2, :default => 0
      t.integer :packages, :sender_id, :recipient_id, :carrier_id, :vendor_id
      t.datetime :date
      t.text :notes
      t.timestamps
    end
  end

  def self.down
    drop_table :register_es
  end
end

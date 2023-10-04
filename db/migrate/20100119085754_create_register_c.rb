class CreateRegisterC < ActiveRecord::Migration[6.0]
  def self.up
    create_table :register_cs do |t|
      t.string :code, :plate_number, :operation
      t.boolean :customs, :default => 0
      t.decimal :cost, :precision => 12, :scale => 2, :default => 0
      t.decimal :net_stock, :precision => 12, :scale => 2, :default => 0
      t.decimal :net_customs, :precision => 12, :scale => 2, :default => 0
      t.decimal :net_transport, :precision => 12, :scale => 2, :default => 0
      t.decimal :gross, :precision => 12, :scale => 2, :default => 0
      t.integer :sender_id, :recipient_id
      t.datetime :date
      t.text :notes
      t.timestamps
    end
  end

  def self.down
    drop_table :register_cs
  end
end

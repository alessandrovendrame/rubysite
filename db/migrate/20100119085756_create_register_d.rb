class CreateRegisterD < ActiveRecord::Migration[6.0]
  def self.up
    create_table :register_ds do |t|
      t.string :code, :timeframe, :operation_type, :cadence
      t.decimal :cost, :precision => 12, :scale => 2, :default => 0
      t.decimal :net, :precision => 12, :scale => 2, :default => 0
      t.decimal :gross, :precision => 12, :scale => 2, :default => 0
      t.integer :sender_id
      t.datetime :date
      t.text :notes
      t.timestamps
    end
  end

  def self.down
    drop_table :register_ds
  end
end

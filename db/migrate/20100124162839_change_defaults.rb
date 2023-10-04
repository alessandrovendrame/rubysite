class ChangeDefaults < ActiveRecord::Migration[6.0]
  def self.up
    
    change_table :register_as do |t|
      t.change :cost, :decimal, :precision => 12, :scale => 2, :default => nil
      t.change :net_stock, :decimal, :precision => 12, :scale => 2, :default => nil
      t.change :net_customs, :decimal, :precision => 12, :scale => 2, :default => nil
      t.change :net_transport, :decimal, :precision => 12, :scale => 2, :default => nil
      t.change :gross, :decimal, :precision => 12, :scale => 2, :default => nil
    end

    change_table :register_bs do |t|
      t.change :cost, :decimal, :precision => 12, :scale => 2, :default => nil
      t.change :net_stock, :decimal, :precision => 12, :scale => 2, :default => nil
      t.change :net_customs, :decimal, :precision => 12, :scale => 2, :default => nil
      t.change :net_transport, :decimal, :precision => 12, :scale => 2, :default => nil
      t.change :gross, :decimal, :precision => 12, :scale => 2, :default => nil
    end

    change_table :register_cs do |t|
      t.change :cost, :decimal, :precision => 12, :scale => 2, :default => nil
      t.change :net_stock, :decimal, :precision => 12, :scale => 2, :default => nil
      t.change :net_customs, :decimal, :precision => 12, :scale => 2, :default => nil
      t.change :net_transport, :decimal, :precision => 12, :scale => 2, :default => nil
      t.change :gross, :decimal, :precision => 12, :scale => 2, :default => nil
    end
    
    change_table :register_ds do |t|
      t.change :cost, :decimal, :precision => 12, :scale => 2, :default => nil
      t.change :net, :decimal, :precision => 12, :scale => 2, :default => nil
      t.change :gross, :decimal, :precision => 12, :scale => 2, :default => nil
    end
    
    change_table :register_es do |t|
      t.change :nole_cost, :decimal, :precision => 12, :scale => 2, :default => nil
      t.change :bl_cost, :decimal, :precision => 12, :scale => 2, :default => nil
      t.change :transport_cost, :decimal, :precision => 12, :scale => 2, :default => nil
      t.change :stop_cost, :decimal, :precision => 12, :scale => 2, :default => nil
      t.change :incidental_cost, :decimal, :precision => 12, :scale => 2, :default => nil
      t.change :net, :decimal, :precision => 12, :scale => 2, :default => nil
      t.change :gross, :decimal, :precision => 12, :scale => 2, :default => nil
    end
  
  end

  def self.down
  end
end

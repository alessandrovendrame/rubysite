class CreateLogEntries < ActiveRecord::Migration[6.0]
  def self.up
    create_table :log_entries do |t|
      t.integer :user_id
      t.string :description, :ip
      t.timestamps
    end
  end

  def self.down
    drop_table :log_entries
  end
end

class CreateLevels < Sequel::Migration
  def self.up
    create_table :levels do |t|
      t.column :user_id, :integer, :nil => false
      t.column :channel_id, :integer, :nil => false
      t.column :level, :integer, {:nil => false, :default => 0}
      t.column :flags, :string # Holdover from eggdrop users, might get imported
      t.timestamps
    end unless DB.table_exists?(:levels)
  end

  def self.down
    drop_table :levels if DB.table_exists?(:levels)
  end
end

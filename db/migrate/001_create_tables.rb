class CreateTables < Sequel::Migration
  # Create the initial tables for the database
  def self.up
    create_table :bans do |t| # {{{ 
      t.column :hostmask_id, :integer, :null => false
      t.column :created_by, :integer
      t.column :channel_id, :integer # If no channel and no server, we'll assume its global
      t.column :server_id, :integer # If no server and no channel, we'll assume its global
      t.column :created_at, :datetime, :null => false
    end unless DB.table_exists?(:bans) # }}}

    create_table :channels do |t| # {{{
      t.column :created_by, :integer
      t.column :updated_by, :integer
      t.column :flags, :string
      t.timestamps
    end unless DB.table_exists?(:channels) # }}}

    create_table :consoles do |t| # {{{
      t.timestamps
      t.column :channel_id, :integer
      t.column :user_id, :integer, :null => false
      t.column :flags, :string
    end unless DB.table_exists?(:consoles) # }}}

    create_table :exemptions do |t| # {{{
      t.column :hostmask_id, :integer, :null => false
      t.column :created_at, :datetime, :null => false
      t.column :created_by, :integer
      t.column :channel_id, :integer # If no channel, we'll assume its global
    end unless DB.table_exists?(:exemptions) # }}}

    create_table :hostmasks do |t| # {{{
      t.column :created_at, :datetime, :null => false
      t.column :created_by, :integer
      t.column :mask, :string, :null => false
    end unless DB.table_exists?(:hostmasks) # }}}

    create_table :ignores do |t| # {{{
      t.column :hostmask_id, :integer, :null => false
      t.column :created_at, :datetime, :null => false
      t.column :created_by, :integer
      t.column :channel_id, :integer # If no channel and no server, we'll assume its global
      t.column :server_id, :integer # If no server and no channel, we'll assume its global
    end unless DB.table_exists?(:ignores) # }}}

    create_table :networks do |t| # {{{
      t.column :created_at, :datetime, :null => false
      t.column :created_by, :integer
      t.column :name, :string
      t.column :description, :string
    end unless DB.table_exists?(:networks) # }}}

    create_table :servers do |t| # {{{
      t.column :created_at, :datetime, :null => false
      t.column :created_by, :integer
      t.column :hostname, :string, :null => false
      t.column :port, :integer, :null => false
      t.column :network_id, :integer
    end unless DB.table_exists?(:servers) # }}}

    create_table :users do |t| # {{{
      t.column :authorized, :boolean, :null => false, :default => true
      t.column :bot_flags, :string
      t.column :comment, :string
      t.column :created_at, :datetime, :null => false
      t.column :created_by, :integer
      t.column :flags, :string
      t.column :info_line, :string
      t.column :last_seen_at, :datetime
      t.column :last_seen_on, :integer # Last place we saw the user
      t.column :nick, :string
      t.column :password, :string
      t.column :updated_by, :integer
      t.column :updated_at, :datetime, :null => false
    end unless DB.table_exists?(:users) # }}}

    create_table :users_hostmasks do |t| # {{{
      t.column :created_at, :datetime, :null => false
      t.column :created_by, :integer
      t.column :hostmask_id, :integer, :null => false
      t.column :user_id, :integer, :null => false
    end unless DB.table_exists?(:users_hostmasks) # }}}
  end

  def self.down
    [:bans,:channels,:console,:exemptions,:hostmasks,:ignores,:servers,:users,:users_hostmasks].each do |t|
      drop_table t if DB.table_exists?(t)
    end
  end
end

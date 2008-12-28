class CreateTables < Sequel::Migration
  # Create the initial tables for the database
  def up
    create_table :bans do # {{{ 
      primary_key :id
      column :hostmask_id, :integer, :null => false
      column :created_by, :integer
      column :channel_id, :integer # If no channel and no server, we'll assume its global
      column :server_id, :integer # If no server and no channel, we'll assume its global
      column :created_at, :timestamp, :null => false, :default => "now()"
      column :updated_at, :timestamp, :null => false, :default => "now()"
    end unless DB.table_exists?(:bans) # }}}

    create_table :channels do # {{{
      column :created_by, :integer
      column :updated_by, :integer
      column :flags, :string
      column :created_at, :timestamp, :null => false, :default => "now()"
      column :updated_at, :timestamp, :null => false, :default => "now()"
    end unless DB.table_exists?(:channels) # }}}

    create_table :consoles do # {{{
      column :channel_id, :integer
      column :user_id, :integer, :null => false
      column :flags, :string
      column :created_at, :timestamp, :null => false, :default => "now()"
      column :updated_at, :timestamp, :null => false, :default => "now()"
    end unless DB.table_exists?(:consoles) # }}}

    create_table :exemptions do # {{{
      column :hostmask_id, :integer, :null => false
      column :created_at, :timestamp, :null => false, :default => "now()"
      column :updated_at, :timestamp, :null => false, :default => "now()"
      column :created_by, :integer
      column :channel_id, :integer # If no channel, we'll assume its global
    end unless DB.table_exists?(:exemptions) # }}}

    create_table :hostmasks do # {{{
      column :created_at, :timestamp, :null => false, :default => "now()"
      column :updated_at, :timestamp, :null => false, :default => "now()"
      column :created_by, :integer
      column :mask, :string, :null => false
    end unless DB.table_exists?(:hostmasks) # }}}

    create_table :ignores do # {{{
      column :hostmask_id, :integer, :null => false
      column :created_at, :timestamp, :null => false, :default => "now()"
      column :updated_at, :timestamp, :null => false, :default => "now()"
      column :created_by, :integer
      column :channel_id, :integer # If no channel and no server, we'll assume its global
      column :server_id, :integer # If no server and no channel, we'll assume its global
    end unless DB.table_exists?(:ignores) # }}}

    create_table :levels do # {{{
      column :user_id, :integer, :nil => false
      column :channel_id, :integer, :nil => false
      column :level, :integer, {:nil => false, :default => 0}
      column :flags, :string # Holdover from eggdrop users, might get imported
      column :created_at, :timestamp, :null => false, :default => "now()"
      column :updated_at, :timestamp, :null => false, :default => "now()"
    end unless DB.table_exists?(:levels) # }}}

    create_table :networks do # {{{
      column :created_at, :timestamp, :null => false, :default => "now()"
      column :updated_at, :timestamp, :null => false, :default => "now()"
      column :created_by, :integer
      column :name, :string
      column :description, :string
    end unless DB.table_exists?(:networks) # }}}

    create_table :servers do # {{{
      column :created_at, :timestamp, :null => false, :default => "now()"
      column :updated_at, :timestamp, :null => false, :default => "now()"
      column :created_by, :integer
      column :hostname, :string, :null => false
      column :port, :integer, :null => false
      column :network_id, :integer
    end unless DB.table_exists?(:servers) # }}}

    create_table :users do # {{{
      column :authorized, :boolean, :null => false, :default => true
      column :bot_flags, :string
      column :comment, :string
      column :created_at, :timestamp, :null => false, :default => "now()"
      column :created_by, :integer
      column :flags, :string
      column :info_line, :string
      column :last_seen_at, :timestamp
      column :last_seen_on, :integer # Last place we saw the user
      column :nick, :string
      column :password, :string
      column :updated_by, :integer
      column :updated_at, :timestamp, :null => false, :default => "now()"
    end unless DB.table_exists?(:users) # }}}

    create_table :users_hostmasks do # {{{
      column :created_at, :timestamp, :null => false, :default => "now()"
      column :created_by, :integer
      column :hostmask_id, :integer, :null => false
      column :user_id, :integer, :null => false
    end unless DB.table_exists?(:users_hostmasks) # }}}
  end

  def down
    [:bans,:channels,:console,:exemptions,:hostmasks,:ignores,:levels,:servers,:users,:users_hostmasks].each do |t|
      drop_table t if DB.table_exists?(t)
    end
  end
end

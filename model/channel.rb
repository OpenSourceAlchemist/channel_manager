# A Channel exists on a specific network, and has many users

class Channel < Sequel::Model
  one_to_many :bans
  one_to_many :consoles
  one_to_many :servers
  many_to_many :users, :join_table => :users_channels
end

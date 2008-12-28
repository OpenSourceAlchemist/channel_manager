# The Console is what a user typically sees when they telnet in to the bot

class Console < Sequel::Model
  many_to_one :user
  many_to_one :channel
end

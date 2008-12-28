# Denotes a user's standing in a channel (and provides the link between the user and that channel)
class Level < Sequel::Model
  many_to_one :channel
  many_to_one :user
end

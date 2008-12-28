# An exemption, created by somebody for a hostmask
# "[address]:[port]".

class Exemption < Sequel::Model
  many_to_one :channel
  many_to_one :hostmask
  many_to_one :creator, :class => :user, :foreign_key => :creator_id
end

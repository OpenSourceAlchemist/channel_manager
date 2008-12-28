# An Ban belongs to a Channel and has a matching Hostmask

class Ban < Sequel::Model
  many_to_one :channel
  many_to_one :hostmask
end

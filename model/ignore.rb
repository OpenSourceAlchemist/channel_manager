# An Ignore is meant to identify hosts that should be completely ignored on specific channels

class Ignore < Sequel::Model
  many_to_one :channel
end

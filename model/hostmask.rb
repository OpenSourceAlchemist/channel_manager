# A hostmask can belong to many things

class Hostmask < Sequel::Model
  one_to_many :user_hostmask, :class_name => "UserHostmask"
  many_to_many :users, :through => :users_hostmasks
  one_to_many :ignore
  one_to_many :ban
  one_to_many :exemption
end

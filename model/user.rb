# An IRC member recognized by the bot.

require "md5"

class User < Sequel::Model
  one_to_many :levels
  one_to_many :user_hostmasks, :class_name => "UserHostmask"
  many_to_many :channels, :through => :levels
  many_to_many :hostmasks, :through => :users_hostmasks
  one_to_many :consoles

  def self.find_by_hostmask(given_mask)
    mask = Hostmask.find(:all).detect { |a| IrcNetmask.netmaskmatch(a.mask, given_mask) }
    return nil if mask.nil?
    mask.user
  end

  def password=(given_password)
    self[:password] = MD5::md5(given_password).to_s
  end

  def authenticate(given_password)
    MD5::md5(given_password).to_s == password
  end
end

# Controller for the Manager leaf.
my_path = File.expand_path(File.dirname(__FILE__))
require File.expand_path(File.join(my_path, "..", "model", "init.rb"))

class Controller < Autumn::Leaf
  
  # Typing "!about" displays some basic information about this leaf.
  def ban_command(stem, sender, reply_to, msg)
    return unless (user = User.find_by_hostmask(IrcNetmask.mask_from_sender(sender)))
    return unless reply_to == @options[:management_channel]
  end
  
  def about_command(stem, sender, reply_to, msg)
    # This method renders the file "about.txt.erb"
  end

  def op_command(stem, sender, reply_to, msg) # Make it available via msg or web server only
    if reply_to.match(/^#/)
      stems.message("Hey, dumbass, you can't authenticate in public")
    else
      if user = User.find_by_hostmask(IrcNetmask.mask_from_sender(sender))
        if user.authenticate(msg)
          stems.grant_user_privilege(@options[:management_channel], sender[:nick], 'o')
        end
      else
        stems.message("Hey, you can't authenticate, I dunno who you are!", reply_to)
      end
    end
  end

  def someone_did_join_channel(stem, sender, channel)
    hostmask = "#{sender[:nick]}!#{sender[:user]}@#{sender[:host]}"
    if @user = User.find_by_hostmask(hostmask)
       stems.message("Hey, I know you as #{@user.nick}, how ya been?", sender[:nick])
       @user.update_attributes(:last_seen_at =>  DateTime.now, :last_seen_on => channel)
    else
      stems.message("Hey, #{sender[:nick]}, welcome to #pho I don't know you", sender[:nick])
    end
  end

  def first_user_command(stem, sender, reply_to, msg)
    stems.message("First user is #{user = User.find(:first).inspect}", reply_to)
    stems.message("Users hostmasks are #{user.hostmasks.map { |n| n.inspect }.join(", ")}")
  end

  private
  def authorize?(sender)

  end

  #def authenticate(stem, channel, sender, leaf)
  #end
end

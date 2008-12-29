# Here goes your database connection and options
require "sequel"
require "logger"

CHANMGR_DB = ENV["CHANMGR_DB"] unless ENV["CHANMGR_DB"].nil?
CHANMGR_DB = "sqlite://#{File.expand_path(File.join(File.dirname(__FILE__),".."))}/db/channel_manager.sqlite" unless Object.const_defined? "CHANMGR_DB"
CHANMGR_ENV = ENV["CHANMGR_ENV"] unless ENV["CHANMGR_ENV"].nil?
CHANMGR_ENV = "development" unless Object.const_defined? "CHANMGR_ENV"
DB = Sequel.connect(CHANMGR_DB, :loggers => Logger.new(File.join(File.dirname(__FILE__),"..","log","#{CHANMGR_ENV}.log")))
# Require all models in '/model/*.rb'
Dir[File.join(File.dirname(__FILE__), "*.rb")].each { |file| require file }

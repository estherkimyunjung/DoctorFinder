require 'bundler/setup'
Bundler.require

require 'sinatra/activerecord'
require 'rake'
require_all 'app/models'
require_all 'lib'


# put the code to connect to the database here
ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/module.sqlite"
)

ActiveRecord::Base.logger = Logger.new(STDOUT)

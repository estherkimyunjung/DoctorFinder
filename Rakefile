require_relative 'config/environment.rb'
require "sinatra/activerecord/rake"

desc "start console"
task :console do
  ActiveRecord::Base.logger = nil
  Pry.start
end

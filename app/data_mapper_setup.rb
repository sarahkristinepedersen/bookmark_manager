require 'data_mapper'

if ENV['RACK_ENV'] == "production"
  DataMapper.setup(:default, ENV['DATABASE_URL'])
else
  DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")
end
DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")
require './app/models/link'
DataMapper.finalize
DataMapper.auto_upgrade!
require 'support/user'
require 'support/schema'

begin
  ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database => File.dirname(__FILE__) + "/password_schema_validator.sqlite3"
  )
rescue
  puts "Connection not established"
end

connection = ActiveRecord::Base.connection

unless connection.table_exists? 'users'
  UserCreate.migrate(:change)
end

# require 'password_schema_validator' # and any other gems you need

RSpec.configure do |config|
  # some (optional) config here
  # config.use_transactional_fixtures = true
end

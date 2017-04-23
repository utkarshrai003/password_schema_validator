require 'support/user'
require 'support/schema'
require 'rspec'

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

RSpec.configure do |config|
  config.add_setting :use_transactional_fixtures, default: true
end

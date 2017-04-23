
# Gem description and dependency listing
Gem::Specification.new do |s|
  s.name      = "password_schema_validator"
  s.version   = '1.0'
  s.authors   = ["Utkarsh Rai"]
  s.email     = ["utkarshrai003@gmail.com"]
  s.homepage  = "https://github.com/utkarshrai003/password_schema_validator"
  s.files      = Dir["lib/password_schema_validator.rb", "lib/password_schema_validator/**/*.rb"]
  s.summary   = "An activeModel Validator that provides a quick and easy way to validate a password against a user defined schema"
  s.licenses  = ["MIT"]

  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "sqlite3-ruby"
  s.add_development_dependency "rspec", "~> 2.3"
  s.add_development_dependency "activerecord", "~> 4.0.0"
end

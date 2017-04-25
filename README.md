[![CircleCI](https://circleci.com/gh/utkarshrai003/password_schema_validator/tree/master.svg?style=svg)](https://circleci.com/gh/utkarshrai003/password_schema_validator/tree/master)

# password_schema_validator

Password Schema Validator is an extension for Active Model Validations that provides an easy way to validate a password or a string against a user defined schema. This gem is a motivation from the npm module - https://github.com/tarunbatra/password-validator

## Install

gem 'password_schema_validator', '~> 1.0'

## Usage

Password Schema Validator needs to be used like a usual Rails model validation. Suppose, a field named 'password' is to be validated. For this, a schema needs to be defined with the options available in the *'password_schema_validator'* and this schema should to be passed to the *'with_schema'* validator.

class User  
&nbsp;&nbsp;&nbsp;&nbsp;validates :name, presence: true     
&nbsp;&nbsp;&nbsp;&nbsp;validates :password, with_schema: {   
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;min_len: 5,   
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;max_len: 10,   
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;digits: true   
&nbsp;&nbsp;&nbsp;&nbsp;}  
end

and now, one can use this as .........

user = User.new(name: "duke_nukem", password: "pass")  
user.valid? # false  
user.errors.messages # { :password => ["must be minimum 5 character long", "must contain digits"] }

user = User.new(name: "duke_nukem", password: "$pass123")  
user.valid? # true

## Validation Options

Option key | Value datatype | Description
---------- | -------------- | -----------
**min_len** | `integer` | validates if the password has at least "min_len" characters.
**max_len** | `integer` | validates if the password has not more than "max_len" characters.
**lower_case** | `boolean` | validates if the password has at least one lower case character.
**upper_case** | `boolean` | validates if the password has at least one upper case character.
**letters**  | `boolean` | validates if the password has at least one letter [a-z, A-Z].
**digits** | `boolean` | validates if the password has at least one numerical character.
**special_charater** | `boolean` | validates if the password has at least one special character.
**discarded_words** | `array` | validates if the password if not one among the discarded word list.

## ToDo

* Add option to support a dictionary of weak passwords to prevent user from choosing some weak passwords like "password" or "password123".
* Add option to support explicitely specify allowed special characters in the options.
* Documentation via Rdoc.

## Contributing

Pull Requests and Bug Fixes are most welcome. 

* Fork the Project.
* Run bundle.
* Make your feature branch or Bug-Fix.
* Add tests for it. This is important so that it doesn't break future versions unintentionally.
* Commit the changes without messing with the history or version.
* Create Pull request.


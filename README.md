# password_schema_validator

Password Schema Validator is an extension for Active Model Validations that provides an easy way to validate a password or a string against a user defined schema.

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
**digits** | `boolean` | validates if the password has at least one numerical character.
**special_charater** | `boolean` | validates if the password has at least one special character.
**discarded_words** | `array` | validates if the password if not one among the discarded word list.



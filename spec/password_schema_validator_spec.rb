require 'spec_helper'

describe 'Password Schema Validator' do
  context 'When a Password field is validated using Password Schema Validator' do

    context "When 'min_len' attribute is specified" do
      before do
        class User
          validates :password, with_schema: {
            min_len: 5
          }
        end
      end

      it "should return false when password length is less than 'min_len' specified" do
        user = User.new(password: "pass")
        expect(user.valid?).to eq(false)
      end

      it "should return true when password length is less than or equal to 'min_len' specified" do
        user = User.new(password: "password")
        expect(user.valid?).to eq(true)
      end
    end

    context "When 'max_len' attribute is specified" do
      before do
        class User
          validates :password, with_schema: {
            max_len: 8
          }
        end
      end

      it "should return false when password length is more than 'max_len' specified" do
        user = User.new(password: "password1234")
        expect(user.valid?).to eq(false)
      end

      it "should return true when password length is less than or equal to 'max_len' specified" do
        user = User.new(password: "password")
        expect(user.valid?).to eq(true)
      end
    end

    context "When 'lower_case' attribute is specified" do
      before do
        class User
          validates :password, with_schema: {
            lower_case: true
          }
        end
      end

      it "should return false when password does not contain any lower-case letter" do
        user = User.new(password: "$PASS123")
        expect(user.valid?).to eq(false)
      end

      it "should return true when password contain at least one lower-case letter" do
        user = User.new(password: "$Pass123")
        expect(user.valid?).to eq(true)
      end
    end

    context "When 'upper_case' attribute is specified" do
      before do
        class User
          validates :password, with_schema: {
            upper_case: true
          }
        end
      end

      it "should return false when password does not contain any upper-case letter" do
        user = User.new(password: "$pass123")
        expect(user.valid?).to eq(false)
      end

      it "should return true when password contain at least one upper-case letter" do
        user = User.new(password: "$Pass123")
        expect(user.valid?).to eq(true)
      end
    end

  end
end

# gem 'password_schema_validator', '0.0.0.1', :path => './password_schema_validator-0.0.0.1'

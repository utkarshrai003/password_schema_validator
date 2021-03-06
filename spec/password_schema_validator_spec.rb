require 'spec_helper'
require 'pry'

describe 'Password Schema Validator' do
  describe 'When a Password field is validated using Password Schema Validator' do

    context "# min_len attribute" do
      context "When 'min_len' attribute is specified" do
        before do
          User.clear_validators!
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

        it "should push appropriate error message for the failed Validation"  do
          user = User.new(password: "pass")
          user.valid?
          expect(user.errors[:password]).to include("must be minimum 5 charecter long")
        end

        it "should return true when password length is greater than or equal to 'min_len' specified" do
          user = User.new(password: "password")
          expect(user.valid?).to eq(true)
        end
      end

      context "When 'min_len' attribute is supplied with wrong datatype value" do
        it "should raise Error stating - 'min_len' must be an integer" do
          expect {
            User.clear_validators!
            class User
              validates :password, with_schema: {
                min_len: "five"
              }
            end
          }.to raise_error("'min_len' must be of type integer")
        end
      end
    end


    context "# max_len attribute" do
      context "When 'max_len' attribute is specified" do
        before do
          User.clear_validators!
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

        it "should push appropriate error message for the failed Validation"  do
          user = User.new(password: "password1234")
          user.valid?
          expect(user.errors[:password]).to include("must be maximum 8 charecter long")
        end

        it "should return true when password length is less than or equal to 'max_len' specified" do
          user = User.new(password: "password")
          expect(user.valid?).to eq(true)
        end
      end

      context "When 'max_len' attribute is supplied with wrong datatype value" do
        it "should raise Error stating - 'min_len' must be an integer" do
          expect {
            class User
              validates :password, with_schema: {
                max_len: true
              }
            end
          }.to raise_error("'max_len' must be of type integer")
        end
      end
    end

    context "# lower_case attribute" do
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

        it "should push appropriate error message for the failed Validation"  do
          user = User.new(password: "$PASS123")
          user.valid?
          expect(user.errors[:password]).to include("must contain lower-case letters")
        end

        it "should return true when password contain at least one lower-case letter" do
          user = User.new(password: "$Pass123")
          expect(user.valid?).to eq(true)
        end
      end

      context "When 'lower_case' attribute is supplied with wrong datatype value" do
        it "should raise Error stating - 'lower_case' must be of type boolean" do
          expect {
            User.clear_validators!
            class User
              validates :password, with_schema: {
                lower_case: "lower"
              }
            end
          }.to raise_error("'lower_case' must be of type boolean")
        end
      end
    end

    context "# upper_case attribute" do
      context "When 'upper_case' attribute is specified" do
        before do
        User.clear_validators!
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

        it "should push appropriate error message for the failed Validation"  do
          user = User.new(password: "$pass123")
          user.valid?
          expect(user.errors[:password]).to include("must contain upper-case letters")
        end

        it "should return true when password contain at least one upper-case letter" do
          user = User.new(password: "$Pass123")
          expect(user.valid?).to eq(true)
        end
      end

      context "When 'upper_case' attribute is supplied with wrong datatype value" do
        it "should raise Error stating - 'upper_case' must be of type boolean" do
          expect {
            User.clear_validators!
            class User
              validates :password, with_schema: {
                upper_case: "upper"
              }
            end
          }.to raise_error("'upper_case' must be of type boolean")
        end
      end
    end

    context "# digits attribute" do
      context "When 'digits' attribute is specified" do
        before do
        User.clear_validators!
          class User
            validates :password, with_schema: {
              digits: true
            }
          end
        end

        it "should return false when password does not contain any digits" do
          user = User.new(password: "$password")
          expect(user.valid?).to eq(false)
        end

        it "should push appropriate error message for the failed Validation"  do
          user = User.new(password: "$password")
          user.valid?
          expect(user.errors[:password]).to include("must contain digits")
        end

        it "should return true when password contain at least one digit" do
          user = User.new(password: "$Pass123")
          expect(user.valid?).to eq(true)
        end
      end

      context "When 'digits' attribute is supplied with wrong datatype value" do
        it "should raise Error stating - 'digits' must be of type boolean" do
          expect {
            User.clear_validators!
            class User
              validates :password, with_schema: {
                digits: 2
              }
            end
          }.to raise_error("'digits' must be of type boolean")
        end
      end
    end

    context "# letters attribute" do
      context "When 'letters' attribute is specified" do
        before do
        User.clear_validators!
          class User
            validates :password, with_schema: {
              letters: true
            }
          end
        end

        it "should return false when password does not contain any letters" do
          user = User.new(password: "$122_#")
          expect(user.valid?).to eq(false)
        end

        it "should push appropriate error message for the failed Validation"  do
          user = User.new(password: "$122_#")
          user.valid?
          expect(user.errors[:password]).to include("must contain letters")
        end

        it "should return true when password contain at least one letter" do
          user = User.new(password: "$Pass123")
          expect(user.valid?).to eq(true)
        end
      end

      context "When 'letters' attribute is supplied with wrong datatype value" do
        it "should raise Error stating - 'letters' must be of type boolean" do
          expect {
            User.clear_validators!
            class User
              validates :password, with_schema: {
                letters: 2
              }
            end
          }.to raise_error("'letters' must be of type boolean")
        end
      end
    end

    context "# special_characters attribute" do
      context "When 'special_characters' attribute is specified" do
        before do
        User.clear_validators!
          class User
            validates :password, with_schema: {
              special_characters: true
            }
          end
        end

        it "should return false when password does not contain any special_characters" do
          binding.pry
          user = User.new(password: "password123")
          expect(user.valid?).to eq(false)
        end

        it "should push appropriate error message for the failed Validation"  do
          user = User.new(password: "password123")
          user.valid?
          expect(user.errors[:password]).to include("must contain special characters")
        end

        it "should return true when password contain at least one special_charecter" do
          user = User.new(password: "$Pass123")
          expect(user.valid?).to eq(true)
        end
      end

      context "When 'special_characters' attribute is supplied with wrong datatype value" do
        it "should raise Error stating - 'special_characters' must be of type boolean" do
          expect {
            User.clear_validators!
            class User
              validates :password, with_schema: {
                special_characters: 2
              }
            end
          }.to raise_error("'special_characters' must be of type boolean")
        end
      end
    end

    context "# discarded_words attribute" do
      context "When 'discarded_words' attribute is specified" do
        before do
        User.clear_validators!
          class User
            validates :password, with_schema: {
              discarded_words: ["password", "$pass123", "password123"]
            }
          end
        end

        it "should return false when the password is one of the discared words" do
          user = User.new(password: "password123")
          expect(user.valid?).to eq(false)
        end

        it "should push appropriate error message for the failed Validation"  do
          user = User.new(password: "password123")
          user.valid?
          expect(user.errors[:password]).to include("must not be in the discarded words")
        end

        it "should return true when password is not in discarded words" do
          user = User.new(password: "$randomPass")
          expect(user.valid?).to eq(true)
        end
      end

      context "When 'discarded_words' attribute is supplied with wrong datatype value" do
        it "should raise Error stating - 'discarded_words' must be of type array" do
          expect {
            User.clear_validators!
            class User
              validates :password, with_schema: {
                discarded_words: "password, pass123"
              }
            end
          }.to raise_error("'discarded_words' must be of type array")
        end
      end
    end

  end
end

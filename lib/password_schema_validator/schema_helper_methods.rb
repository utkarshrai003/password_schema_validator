require_relative 'class_specifier'

module SchemaHelperMethods
  include ClassSpecifier

  RESERVED_OPTIONS = {
    min_len: :integer,
    max_len: :integer,
    lower_case: :boolean,
    upper_case: :boolean,
    letters: :boolean,
    digits: :boolean,
    special_characters: :boolean_or_array,
    allowed_special_chareters: :array,
    discarded_words: :array,
    dictionary: :boolean
  }

  SPECIAL_CHARACTERS = " !\"#$%&'()*+,-./:;<=>?@[\]^_`{|}~"

  def match_against_schema(record, attr_name, string)
    options.each do |attribute|
      key, value = attribute
      error_msg = send(key, value, string)
      record.errors.add(attr_name, error_msg, options) if error_msg
    end
  end

  def min_len(minValue, string)
    return "must be minimum " + minValue.to_s + " charecter long" if string.length < minValue.to_i
  end

  def max_len(maxValue, string)
    return "must be maximum " + maxValue.to_s + " charecter long" if string.length > maxValue.to_i
  end

  def lower_case(validate, string)
    return "must contain lower-case letters" if validate && !(/[a-z]+/ =~ string)
  end

  def upper_case(validate, string)
    return "must contain upper-case letters" if validate && !(/[A-Z]+/ =~ string)
  end

  def letters(validate, string)
    return "must contain letters" if validate && !(/[a-zA-Z]+/ =~ string)
  end

  def digits(validate, string)
    return "must contain digits" if validate && !(/\d+/ =~ string)
  end

  def special_characters(option, string)
    binding.pry
    regex = get_regex(option)
    return "must contain special characters" if option && !(regex =~ string)
  end

  def allowed_special_chareters
  end

  def discarded_words(black_listed_words, string)
    return "must not be in the discarded words" if black_listed_words.map(&:downcase).include?(string.downcase)
  end

  def dictionary
  end

  def validate_schema(options)
    options.each do |attribute|
      validate_attribute(attribute)
    end
  end

  def validate_attribute(attribute)
    key, value = attribute
    if RESERVED_OPTIONS[key.to_sym].nil?
      raise ArgumentError, invalid_key_error(key)
    elsif !send(RESERVED_OPTIONS[key.to_sym]).include?(value.class)
      raise ArgumentError, invalid_value_type(key, RESERVED_OPTIONS[key.to_sym])
    end
  end

  def invalid_key_error(key)
    "Invalid key - '" + key.to_s + "' passed to the schema. Provide a valid permitted key."
  end

  def invalid_value_type(key, expected_type)
    "'" + key.to_s + "' must be of type " + expected_type.to_s.split("_").join(" ")
  end

  def get_regex(option)
    if option.class.eql?(Array) and has_valid_symbols?(option)
      /[#{option.gsub(/./){|char| "\\#{char}"}}]/
    else
      /[#{SPECIAL_CHARACTERS.gsub(/./){|char| "\\#{char}"}}]/
    end
  end

  def has_valid_symbols?(symbols)
    (symbols - SPECIAL_CHARACTERS.split("")).blank?
  end

end

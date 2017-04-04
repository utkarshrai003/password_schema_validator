module SchemaHelperMethods

  RESERVED_OPTIONS = {
    min_len: :integer,
    max_len: :integer,
    lower_case: :boolean,
    upper_case: :boolean,
    digits: :integer,
    special_charecters: :boolean,
    allowed_special_chareters: :array,
    discard_words: :array,
    dictionary: :boolean
  }

  def match_against_schema(record, attr_name, string)
    options.each do |attribute|
      key, value = attribute
      error_msg = send(key, value, string)
      record.errors.add(attr_name, error_msg, options) if error_msg
    end
  end

  def min_len(minValue, string)
    return "must be minimum " + minValue.to_s + " charecter long." if string.length < minValue.to_i
  end

  def max_len(maxValue, string)
    return "must be maximum " + maxValue.to_s + " charecter long." if string.length > maxValue.to_i
  end

  def lower_case(validate, string)
    return "must contain lower-case letters." if validate && !(/[a-z]+/ =~ string)
  end

  def upper_case(validate, string)
    return "must contain upper-case letters." if validate && !(/[A-Z]+/ =~ string)
  end

  def digits(validate, string)
    return "must contain digits." if validate && !(/\d+/ =~ string)
  end

  def special_charecters(validate, string)
    return "must contain special charecters" if validate && !(/[`~\!@#\$%\^\&\*\(\)\-_\=\+\[\{\}\]\\\|;:'",<.>\/\?]+/ =~ string)
  end

  def allowed_special_chareters
  end

  def discard_words
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
    "'" + key.to_s + "' must be of type " + expected_type[0].to_s
  end

  def integer
    [Fixnum]
  end

  def boolean
    [true.class, false.class]
  end

  def array
    [Array]
  end

end

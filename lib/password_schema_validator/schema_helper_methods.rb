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

  def validate_schema
    @attributes.each do |attribute|
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
    "Invalid key - '"key.to_s + "' passed to the schema. Provide a valid permitted key."
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

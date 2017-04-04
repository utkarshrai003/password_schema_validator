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

module ClassSpecifier

  def integer
    [Fixnum]
  end

  def boolean
    [true.class, false.class]
  end

  def array
    [Array]
  end

  def boolean_or_array
    [boolean, array].flatten
  end

end

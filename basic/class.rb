class Sequence
  # This is an enumerable class; it defines an each iterator below.
  include Enumerable # include the methods of this module in this class

  # The initialize method is specical; it is automatically called when a new
  # object is created. It is used to initialize the object's state
  def initialize(from, to, by)
    # Just save our parameters into instance variables for later use
    @from, @to, @by = from, to, by # parallel assignment and @ prefix
  end

  # This is the iterator required by the Enumerable module
  def each
    x = @from # Strart at the starting point
    while x <= @to # While we haven't reached the end
      yield x # Pass x to the block associated with the iterator
      x += @by # Increment x
    end
  end

  # Define the length method (following arrays) to return the number of
  # values in the sequence
  def length
    return 0 if @from > @to
    Integer((@to - @from) / @by) + 1
  end

  # Define another name for the same method
  # It is common for methods to have multiple names in Ruby
  # alias size length # size is now a synonym for length

  # Override the array-access operator to give random access to the sequence
  def[](index)
    return nil if index < 0 # Return nil for negative indexes
    v = @from + index * @by # Compute the value
    if v <= @to # If it is part of the sequence
      v
    else
      nil
    end
  end

  # Override arithmetic operators to return new Sequence objects
  def *(factor)
    Sequence.new(@from * factor, @to * factor, @by * factor)
  end

  def +(offset)
    Sequence.new(@from + offset, @to + offset, @by)
  end
  
end

s = Sequence.new(1, 10, 2)
s.each { |x| print x }
print s[s.length - 1]
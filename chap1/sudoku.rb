class Puzzle
  # These constants are used for translating between the external
  # string representation of a puzzle and the internal representation
  # of a puzzle as an array of integers.
  ASCII = ".123456789".freeze
  BIN = "\000\001\002\003\004\005\006\007\010\011".freeze # 0 is a placeholder, 1-9 are the actual values

  def initialize lines
    s = if lines.respond_to? :join # If argument looks like an array of lines
          lines.join # Then join them into a single string
        else # Otherwise, assume it is a single string
          lines.dup # And make a private copy of it
        end

    # Remove whiespace (including newlines) from the data
    # The "!" in gsub! indicates that this is a mutator method that
    # alters the string directly rather than making a copy
    s.gsub!(/\s/, "") # /\s/ is a Regexp that matches any whitespace

    # Raise an exception if the input is the wrong size.
    # Note that we use unless instead of if, and use it in modifier form.
    raise Invalid, "Grid is the wrong size" unless s.size == 81

    # Check for invalid characters, and save the location of the first.
    # Note that we assign and test the value assigned at the same time.
    if i = s.index(/[^123456789\.]/)
      # Include the invalid character in the error message
      # Note the ruby expression inside #{} in string literal.
      raise Invalid, "Illegal character #{s[i, 1]} in puzzle" # s[i,1] is the substring containing the invalid character
    end

    # The following two lines convert our string of ASCII characters
    # to an array of integers, using two powerful String methods.
    # The resulting array is sorted in the instance variable @grid
    # The number 0 is used to represent an unknown value in the puzzle.
    s.tr!(ASCII, BIN)       # Translate the ASCII characters into bytes
    @grid = s.unpack("c*")  # Now unpack the bytes into an array of numbers

    # Raise an exception if the input is not a valid puzzle
    raise Invalid, "Initial puzzle has duplicates" if has_duplicates?
  end

  # Return the state of puzzle as a string of 9 lines with 9
  # characters (plus newline) on each line.
  def to_s
    # Broken down, the line below works like this:
    # (0..8).collect invokes the code in curly braces 9 times--once
    # for each row--and collects the return value of that code into an
    # array. The code in curly braces takes a subarray of the grid
    # representing a single row and packs its numbers into a string.
    # The join() method joins the elements of the array into a single
    # string with newlines between them. Finally, the tr() method
    # translates the binary string representation into ASCII digits.
    (0..8).map {|r| @grid[r * 9, 9].pack("c9")}.join("\n").tr(BIN, ASCII)
  end

  # Return a duplicate of this Puzzle object.
  # This method overrides Object.dup to copy the @grid array.
  def dup
    copy = super # Make a shallow copy by calling Object.dup
    @grid = @grid.dup # Make a new copy of the internal data
    copy # Return the copied object
  end

  # We override the array access operator to allow access to the
  # individual cells of a puzzle. Puzzles are two-dimensional,
  # and must be indexed with row and column coordinates.
  def [] row, col
    # Convert two-dimensional coordinates into a one-dimensional
    # array index and get and return the cell value at thay index
    @grid[(row * 9) + col]
  end

  # This method allows the array access operator to be used on the
  # lefthand side of an assignment operation. It sets the value of
  # the cell at (row, col) to newValue
  def []= row, col, newValue
    # Raise an exception unless the new value is in the range 0 to 9
    raise Invalid, "Illegal cell value" unless (0..9).include? newValue

    # Set the value of the cell at (row, col) to the new value
    @grid[(row * 9) + col] = newValue
  end

  # This array maps from one-dimensional grid index to box number.
  # It is used in the method below. The name BoxOfIndex begins with a
  # capital letter, so this is a constant. Also, the array has been
  # frozen, so it cannot be modified.
  BoxOfIndex = [
    0, 0, 0, 1, 1, 1, 2, 2, 2, 0, 0, 0, 1, 1, 1, 2, 2, 2, 0, 0, 0, 1, 1, 1, 2, 2, 2,
    3, 3, 3, 4, 4, 4, 5, 5, 5, 3, 3, 3, 4, 4, 4, 5, 5, 5, 3, 3, 3, 4, 4, 4, 5, 5, 5,
    6, 6, 6, 7, 7, 7, 8, 8, 8, 6, 6, 6, 7, 7, 7, 8, 8, 8, 6, 6, 6, 7, 7, 7, 8, 8, 8
  ].freeze

  # This method defines a custom looping construct (an iterator) for
  # Sudoku puzzle. For each cell whose value is unknown, this method
  # passes ("yields") the row number, coloumn number, and box number to the
  # block associated with the iterator.
  def each_unknown
    0.upto 8 do |row| # For each row
      0.upto 8 do |col| # For each column
        index = (row * 9) + col # compute the index of the cell
        next if @grid[index] != 0 # Skip cells that are already filled in

        box = BoxOfIndex[index] # Compute the box number
        yield row, col, box # Invoke the associated block
      end
    end
  end

  # Return true if any row, column, or box has duplicates.
  # Otherwise returns false. Duplicates in rows, columns, or boxes are not
  # allowed in Sudoku, so a return value of true means an invalid puzzle.
  def has_duplicates?
    # uniq! returns nil if all the elements in an array are unique
    # So if uniq! returns something the board has duplicates
    0.upto(8) do |row|
      return true if rowdigits(row).uniq!
    end
    0.upto(8) do |col|
      return true if coldigits(col).uniq!
    end
    0.upto(8) do |box|
      return true if boxdigits(box).uniq!
    end
    false # If no duplicates are found, the puzzle is valid
  end

  # This array holds a set of all Sudoku digits.
  AllDigits = [1, 2, 3, 4, 5, 6, 7, 8, 9].freeze

  # Return an array of all values that could be placed in the cell
  # at (row, col) without creating a duplicate in the row, column, or box.
  # Note that the + operator on array does concatenation but that the
  # - operator performs a set difference operation.
  def possible row, col, box
    AllDigits - (rowdigits(row) + coldigits(col) + boxdigits(box))
  end

  private

  # Return an array of all known values in the specifid row.
  def rowdigits row
    # Extract the subarray that represents the row and remove all zeros.
    # Array subtraction is set differentce, with duplicates removal.
    @grid[row * 9, 9] - [0]
  end

  # Return an array of all known values in the specified column.
  def coldigits col
    result = [] # Start with empty array
    col.step(80, 9) do |i| # Loop from col to the last column up to 80
      v = @grid[i] # Get the value of the cell at that index
      result << v if v != 0 # Add it to the array if non-zero
    end
    result
  end

  # Map box number to the index of the upper-left corner of the box.
  BoxToIndex = [0, 3, 6, 27, 30, 33, 54, 57, 60].freeze

  # Return an array of all known values in the specified box.
  def boxdigits b
    # Convert box number to index of upper-left corner of the box
    i = BoxToIndex[b]
    # Return an array of values, with 0 elements removed.
    [
      @grid[i], @grid[i + 1], @grid[i + 2],
      @grid[i + 9], @grid[i + 10], @grid[i + 11],
      @grid[i + 18], @grid[i + 19], @grid[i + 20]
    ] - [0]
  end
end

# An exception of this class indicates invalid input
class Invalid < StandardError
end

# An exception of this class indicates that a puzzle is over-constrained
# and that no solution is possible.
class Impossible < StandardError
end

def Sudoku.scan puzzle
  unchanged = false

  until unchanged # Keep going until no cells are changed
    unchanged = true # Assume no cells are changed
    rmin, cmin, pmin = nil # Initialize the cell and possible values
    min = 10 # Initialize the number of possible values

    puzzle.each_unknown do |row, col, box| # For each unknown cell
      p = puzzle.possible(row, col, box) # Get the possible values

      case p.size # How many possible values are there?
      when 0 # If no possible values, the puzzle is over-constrained
        raise Impossible
      when 1 # If there is only one possible value
        puzzle[row, col] = p[0] # Fill in the cell
        unchanged = false # The puzzle has changed
      else # If there are multiple possible values
        if unchanged && p.size < min # Is this the best cell so far?
          min = p.size # Remember the number of possible values
          rmin = row
          cmin = col
          pmin = p # Remember the cell and values
        end
      end
    end
  end

  [rmin, cmin, pmin] # Return the best cell and its possible values
end

def Sudoku.solve puzzle
  # Make a private copy of the puzzle that we can modify
  puzzle = puzzle.dup

  r, c, p = scan(puzzle)

  return puzzle if r.nil?

  p.each do |guess|
    puzzle[r, c] = guess

    begin
      return solve(puzzle)
    rescue Impossible
      next
    end

    raise Impossible
  end
end

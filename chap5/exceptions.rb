def factorial n
  raise ArgumentError if n < 1
  return 1 if n == 1
  n * factorial(n - 1)
end

# puts factorial(-1)

# rescue
# begin
  # Any number of Ruby statements go here.
  # Usually, they are executed without exceptions and # execution continues after the end statement.
#  rescue
  # This is the rescue clause; exception-handling code goes here.
  # If an exception is raised by the code above, or propagates up
  # from one of the methods called above, then execution jumps here.
#  end

begin
  x = factorial(0)
rescue ArgumentError => ex
  puts "Try again with a value >= 1"
rescue TypeError => ex
  puts "Try again with an integer"
end
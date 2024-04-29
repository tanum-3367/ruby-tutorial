x = 5
x += 1 if x < 10

data = []
data << x if data

if x > 2
  puts "x is greater than 2"
elsif x < 2
  puts "x is less than 2"
else
  puts "x is equal to 2"
end

puts message if message

if x == 1
  puts "x is 1"
elsif x == 2
  puts "x is 2"
end

a = 10
until a > 10 # Loop until a is greater than 10
  puts a
  a += 1
end

# excute first time and then check the condition
y = 10
loop do
  puts y
  y -= 1
  break if y.zero?
end

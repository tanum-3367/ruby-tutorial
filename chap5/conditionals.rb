x = 5
if x < 10 then
  x += 1
end

data = []
if data
  data << x
end

if x > 2
  puts "x is greater than 2"
elsif x < 2
  puts "x is less than 2"
else
  puts "x is equal to 2"
end

puts message if message

case
when x == 1
  puts "x is 1"
when x == 2
  puts "x is 2"
end

a = 10
until a > 10 do # Loop until a is greater than 10
  puts a
  a += 1
end

# excute first time and then check the condition
y = 10
begin
  puts y
  y = y - 1
end until y == 0 
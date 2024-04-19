# for var in collection do
#  code
# end

hash = { :a => 1, :b => 2, :c => 3 }
hash.each do |key, value|
  puts "#{key} is #{value}"
end

3.times { puts "thank you" }
# data.each { |x| puts x }
[1, 2, 3].map { |x| x ** x}
factorial = 1
2.upto(4) { |x| factorial *= x }
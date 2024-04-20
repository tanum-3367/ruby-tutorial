array = [1, 2, 3]
enumarator = array.to_enum

begin
  loop do
    puts enumarator.next
  end
rescue StopIteration
  puts "Done"
end

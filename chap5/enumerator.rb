array = [1, 2, 3]
enumarator = array.to_enum

begin
  while true
    puts enumarator.next
  end
rescue StopIteration
  puts "Done"
end
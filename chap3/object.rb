s = "Ruby"
t = s
t[-1] = ""
# print s
# print s,t

def modify_array arr
  arr << 4
end

original_array = [1, 2, 3]
modify_array original_array
# puts original_array.inspect

# object id through __id__ method

# use equal? method to compare object
a = "Ruby"
b = c = "Ruby"
a.equal?(b) # false a and b are different objects
b.equal?(c) # true b and c are the same object # true a and b have the same value

# Hash and Array comparison
# Two arrays are equal according to == if they have the same number of elements
# and if their corresponding elements are equal
# Two hashes are == if they contain the same number of key/value pairs, and if
# keys and values are themselves equal

# use <=> to compare object

# use clone and dup to create a copy of object
# clone copies the frozen state of the object, while dup does not
x = "Ruby"
x.clone
x.dup

# print x,d,e

# marshaling object is a way to serialize object to pass data between different
# Ruby programs
class User
  attr_accessor :name, :age

  def initialize name, age
    @name = name
    @age = age
  end
end

user = User.new("John", 30)
marshaled_user = Marshal.dump(user)

puts marshaled_user

File.binwrite("user.dat", marshaled_user)

# read_user = Marshal.load(File.read("user.dat"))

puts read_user.name, read_user.age

# Nhận dữ liệu từ nguồn bên ngoài
external_data = "user input"
external_data.taint # Đánh dấu nhiễm bẩn

puts external_data.tainted? # Output: true

# Sau khi xác minh dữ liệu
external_data.untaint
puts external_data.tainted? # Output: false

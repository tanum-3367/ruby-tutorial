# convert string to symbol and back
str = "strinssg"
sym = str.intern
another_sym = str.to_sym
puts sym.class
puts another_sym.class
puts sym == another_sym

:a = "hello"
:b = "hello"
puts :a == :b
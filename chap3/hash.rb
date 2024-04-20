# should use Symbol in hash, because it work more efficiently than string

hash1 = {test: "this is test", test2: "this is test2"}
hash2 = {test: "this is test", test2: "this is test2"}

puts hash1.eql? hash2 # true
puts hash1[:test]
puts hash1 == hash2 # true

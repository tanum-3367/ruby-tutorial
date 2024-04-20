Array.new # []: returns a new empty array
nils = Array.new(3) # [nil, nil, nil]: new array with 3 nil elements
Array.new(4, 0) # [0, 0, 0, 0]: new array with 4 zeros
Array.new(nils) # [nil, nil, nil]: new array with 3 nil elements
Array.new(3) {|i| i + 1} # [1, 2, 3]: new array with 3 elements

a = ("a".."e").to_a # ['a', 'b', 'c', 'd', 'e']
a[0, 0] # []: this subarray has zero elements # ['a', 'a']

test = []
test << 1 # [1]
test << 2 << 3 # test is now [1, 2, 3]
test << [4, 5] # test is now [1, 2, 3, [4, 5]]

puts test

# array also use | and & for union and intersection
# | removes duplicates
# & returns only elements that are in both arrays

a = [1, 1, 2, 2, 3, 3, 4]
b = [5, 5, 4, 4, 3, 3, 2]
a | b # [1, 2, 3, 4, 5]: duplicates are removed
b | a # [5, 4, 3, 2, 1]: elements are the same, but order is different # [2, 3, 4]
a & b # [2, 3, 4]
b & a # [4, 3, 2]

a = ("A".."Z").to_a
a.each {|x| print x}

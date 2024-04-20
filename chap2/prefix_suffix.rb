class Person
  def name= value
    @name = value.strip.capitalize
  end

  attr_reader :name
end

person = Person.new
person.name = " uong minh tan "
puts person.name

#
# $files # A global variable
# @data # An instance variable
# @@counter # A class variable
# empty? # A Boolean-valued method or predicate
# sort! # An in-place alternative to the regular sort method
# timeout= # A method invoked by assignment

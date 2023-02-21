require 'sqlite3'
 
db = SQLite3::Database.new('test.db')

db.execute('CREATE TABLE test(id INTEGER, name TEXT)')

db.execute("INSERT INTO test (id, name) VALUES(1, 'someone_1')")
db.execute("INSERT INTO test (id, name) VALUES(2, 'person')")
db.execute("INSERT INTO test (id, name) VALUES(3, 'someone_else')")


results = db.execute ('SELECT * FROM test')

results.each do |row|
    puts row.join(":")
end 



# ORIGINAL GIRAFFE CLASS

# class Giraffe 
#     # used to create setter and getter methods for these instance variables
#     attr_accessor :name, :age, :height, :weight, :gender

#     @@all = []

#     def initialize(name, age, height, weight, gender)
#         @name = name
#         @age = age
#         @height = height
#         @weight = weight
#         @gender = gender
#         # self -a class method that returns an array of all the Giraffe 
#         # objects that have been created
#         @@all << self
#     end

#     def to_s
#         "Name: #{@name}, Age: #{@age}, Height: #{@height}, Weight: #{@weight}, Gender: #{@gender}"
#     end
    
#     # reference to class Giraffe object 
#     def self.all
#         @@all
#     end
    
#     # defining the method as a class method to make it accessible from the class and not an instance of the class
#     def self.create_new_giraffe(name, age, height, weight, gender)
#         giraffe = Giraffe.new(name, age, height, weight, gender) 
#     end
# end

# giraffe1 = Giraffe.create_new_giraffe('Gerry', 18, 580, 130, 'M')
# giraffe2 = Giraffe.create_new_giraffe('Loki', 18, 580, 130, 'M')

# puts Giraffe.all
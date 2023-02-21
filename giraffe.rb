# step 1: load the SQLite3 library
require 'sqlite3'

# step 2: define class Giraffe and its methods
class Giraffe

    # step 3: getter and setter methods for instance variables
    attr_accessor :name, :age, :height, :weight, :gender

    # step 4: create a new db connection using sqlite3 library and store it in a variable. pass the db name as arg
    # Execute the SQL statement to create the table

    @@db = SQLite3::Database.new('giraffes.db')
    @@db.execute <<-SQL
        CREATE TABLE IF NOT EXISTS giraffes (
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            name TEXT,
            age INTEGER,
            height INTEGER,
            weight INTEGER,
            gender TEXT
        );
    SQL

    # step 5: constuctor method for the class. why? sets the values of the instance variables
    def initialize(name, age, height, weight, gender)
        @name = name 
        @age = age
        @height = height
        @weight = weight
        @gender = gender 
    end 

    # step 6: use to_s method to return a string representation of the Giraffe object
    def to_s
        "Name: #{name}, Age: #{age}, Height: #{height}, Weight: #{weight}, Gender: #{gender}"
    end 

    # step 7: return an array of all Giraffe objects stored in the db. first execute SQL query to select all rows from the giraffes table
    # then create a new Giraffe object for each row and add it to the giraffes array
    def self.all
        giraffes = []
        @@db.execute('SELECT * FROM giraffes').each do |row|
            giraffe = Giraffe.new(row[1], row[2], row[3], row[4], row[5])
            giraffes << giraffe
        end 
        giraffes
    end 

    # step 8: create a new Giraffe instance and add it to db using INSERT statement (return new obj)
    def self.create_new_giraffe(name, age, height, weight, gender)
        giraffe = Giraffe.new(name, age, height, weight, gender)
        @@db.execute("INSERT INTO giraffes(name, age, height, weight, gender) VALUES(?, ?, ?, ?, ?)", [name, age, height, weight, gender])
        giraffe
    end 

    # step 8: method to find Giraffe obj by name. use .execute SQL query to select the row from the giraffes table
    # and return a new Giraffe obj if a matching row is found else returns nil
    def self.find_by_name(name)
        row = @@db.execute('SELECT * FROM giraffes WHERE name = ?', name).first
        if row
            Giraffe.new(row[1], row[2], row[3], row[4], row[5])
        else 
            nil
        end 
    end 

    # step 9: method to update giraffes table with new values
    def update 
        @@db.execute('UPDATE giraffes SET age = ?, height = ?, weight = ?, gender = ? WHERE name = ?', [@age, @height, @weight, @gender, @name])
    end 

    # step 10: delete from table
    def delete
        @@db.execute("DELETE FROM giraffes WHERE name = ?", [@name])
    end 
end 

# adding new objects to the table in giraffes.db
giraffe1 = Giraffe.create_new_giraffe("Gerry", 18, 580, 150, "M")
giraffe2 = Giraffe.create_new_giraffe('Loki', 12, 480, 120, 'M')
giraffe3 = Giraffe.create_new_giraffe("Benny", 10, 400, 100, "M")
giraffe4 = Giraffe.create_new_giraffe("Bubs", 15, 520, 130, 'F')
giraffe5 = Giraffe.create_new_giraffe("Ella", 20, 600, 200, 'F')

# deleteing from the table (use find_by_name)

# find the Giraffe instance by name
giraffe = Giraffe.find_by_name('Loki')

# delete the Giraffe instance from the database using the delete method
giraffe.delete




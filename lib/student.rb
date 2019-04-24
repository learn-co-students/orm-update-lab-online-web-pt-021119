require_relative "../config/environment.rb"

class Student
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id  = nil
  end

  def update
    sql = "UPDATE students SET name = ?, grade = ? WHERE id = ?"
    db[:conn].execute(sql, self.name, self.grade, self.id)
  end

  def save
    if self.id
      #update
    else
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?,  ?)
      SQL
    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    end
  end

  def self.create_table
    sql = <<-SQL
        CREATE TABLE IF NOT EXISTS students(
          id INTEGER PRIMARY KEY,
          student TEXT,
          grade INTEGER
        )
      SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE students
      SQL
    DB[:conn].execute(sql)
  end
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]


end

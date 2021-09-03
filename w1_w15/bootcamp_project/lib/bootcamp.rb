class Bootcamp
  def initialize(name, slogan, student_capacity)
    @name = name
    @slogan = slogan
    @student_capacity = student_capacity
    @teachers = []
    @students = []
    @grades = Hash.new { |hash, key| hash[key] = [] }
  end

  def name
    @name
  end
  
  def slogan
    @slogan
  end

  def teachers
    @teachers
  end

  def students
    @students
  end

  def hire(teacher)
    @teachers << teacher
  end

  def enroll(student)
    if @student_capacity > @students.length
      @students << student
      return true
    else
      return false
    end
  end

  def enrolled?(student)
    @students.map(&:downcase).include?(student.downcase)
  end

  def student_to_teacher_ratio
    ratio = students.length / teachers.length
    return ratio.floor
  end

  def add_grade(student, grade)
    if enrolled?(student)
      @grades[student] << grade
      return true
    end

    false
  end

  def num_grades(student)
    @grades[student].length
  end

  def average_grade(student)
    if enrolled?(student) && @grades[student].length > 0
      average_grade = @grades[student].sum / @grades[student].length
      return average_grade.floor
    end
  end

end

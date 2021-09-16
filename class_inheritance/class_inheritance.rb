class Employee

  attr_reader :name, :title, :salary
  attr_accessor :boss
  def initialize(name, title, salary, boss = nil)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    salary * multiplier
  end
end

class Manager < Employee

  attr_reader :subordinates
  def initialize(name, title, salary, boss = nil)
    super
    @subordinates = []
  end

  def add_subordinate(sub)
    subordinates << sub
  end

  def bonus(multiplier)
    total_subordinates_salary * multiplier
  end

  def total_subordinates_salary
    if subordinates.none? {|sub| sub.is_a?(Manager)}
      return subordinates.map {|sub| sub.salary}.sum
    end

    total_salary = 0

    subordinates.each do |sub|
      if sub.is_a?(Manager)
        total_salary += sub.salary + sub.total_subordinates_salary
      else
        total_salary += sub.salary
      end
    end

    total_salary
  end
end
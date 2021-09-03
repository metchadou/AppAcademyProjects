require "employee"

class Startup
  attr_reader :name, :funding, :salaries, :employees

  def initialize(name, funding, salaries)
    @name = name
    @funding = funding
    @salaries = salaries
    @employees = []
  end

  def valid_title?(title)
    @salaries.has_key?(title)
  end

  def >(other_startup)
    self.funding > other_startup.funding
  end

  def hire(employee_name, title)
    if valid_title?(title)
      @employees << Employee.new(employee_name, title)
    else
      raise "Invalid title"
    end
  end

  def size
    @employees.length
  end

  def pay_employee(employee)
    employee_salary = @salaries[employee.title]

    if @funding >= employee_salary
      employee.pay(employee_salary)
      @funding -= employee_salary
    else
      raise "Insufficient Funds"
    end
  end

  def payday
    @employees.each { |emp| self.pay_employee(emp) }
  end

  def average_salary
    total_salaries = 0
    @employees.each do |emp|
      total_salaries += @salaries[emp.title]
    end
    
    total_salaries / self.size
  end

  def close
    @employees = []
    @funding = 0
  end

  def acquire(other_startup)
    @funding += other_startup.funding

    other_startup.salaries.each do |title, salary|
      if !@salaries.has_key?(title)
        @salaries[title] = salary
      end
    end

    @employees += other_startup.employees
    
    other_startup.close
  end

end
class Item
  def self.valid_date?(date_string)
    if date_string.length < 7
      return false
    elsif date_string.count("-") != 2
      return false
    else
      date = date_string.split("-").map(&:to_i)
      return false if date.length != 3
    end

    month = date[1]
    day = date[2]
    
    return false if month > 12 || month < 1
    return false if day > 31 || day < 1
    true
  end

  attr_accessor :title, :description
  attr_reader :deadline

  def initialize(title, deadline, description)
    @title = title
    @description = description
    if Item.valid_date?(deadline) == false
      raise "Invalid date"
    else
      @deadline = deadline
    end
  end

  def deadline=(date)
    if Item.valid_date?(date)
      @deadline = date
    else
      raise "Invalid date"
    end
  end
end
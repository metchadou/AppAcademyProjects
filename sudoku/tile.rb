require "colorize"

class Tile

  BLANK = 0

  attr_reader :value
  attr_accessor :previous_value
  def initialize(value)
    @value = value
    @given = value.between?(1,9) ? true : false
    @previous_value = BLANK
  end

  def given?
    @given
  end

  def to_s
    given? ? @value.to_s.colorize(:light_yellow) : 
      @value.to_s.colorize(:light_cyan)
  end

  def update_previous_value(new_val)
    @previous_value = new_val
  end

  def write(new_val)
    if given?
      puts "You cannot change the value of this tile"
    else
      @value = new_val
      update_previous_value(new_val)
    end
    @value
  end

  def draft(new_val)
    if given?
      puts "You cannot change the value of this tile"
    else
      @value = new_val
    end
    @value
  end

  def erase
    if given?
      puts "You cannot erase this tile"
    else
      @value = BLANK
    end
    @value
  end

  def blank?
    @value == BLANK
  end

end
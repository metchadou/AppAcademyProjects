class HumanPlayer
  attr_reader :mark

  def initialize(mark_value)
    @mark = mark_value
  end

  def get_position
    puts "Player #{@mark} enter two numbers representing a position in the format 'row col'"
    entered_position = gets.chomp

    alpha = ("a".."z").to_a
    if alpha.any? {|letter| entered_position.include?(letter) }
      raise "Invalid position"
    elsif entered_position.count(" ") != 1
      raise "Invalid position"
    elsif entered_position.split.length != 2
      raise "Invalid position"
    else
      position = entered_position.split.map(&:to_i)
    end

    position
  end
end
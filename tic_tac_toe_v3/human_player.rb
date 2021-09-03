class HumanPlayer
  attr_reader :mark

  def initialize(mark_value)
    @mark = mark_value
  end

  def get_position(legal_positions)
    position = []

    while !legal_positions.include?(position)
      puts "Player #{@mark} enter two numbers representing a position in the format 'row col'"
      position = gets.chomp.split.map(&:to_i)
      if !legal_positions.include?(position)
        puts "Invalid position entered"
      end
    end

    position
  end
end
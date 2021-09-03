require_relative "board.rb"
class Sudoku

  NUMBERS = (1..9).to_a
  
  def initialize(grid)
    @board = Board.new(grid)
  end

  def congrat
    @board.render
    puts "Congratulations, You Win"
  end

  def prompt
    puts "Enter a position and a value separated by spaces (e,g., '0 1 5')"
    print "> "
  end

  def valid_pos?(pos)
    @board[pos] != nil
  end

  def valid_value?(val)
    NUMBERS.include?(val)
  end

  def valid_input?(input)
    if input.is_a?(Array) && 
    (input.length == 3 && input.all? {|el| el.is_a?(Integer)})
      pos = input.first(2)
      val = input.last
      return valid_pos?(pos) && valid_value?(val)
    end
    false
  end

  def get_input
    gets.chomp.split(" ").map(&:to_i)
  end

  def update_board(input)
    pos = input.first(2)
    val = input.last
    @board[pos] = val
  end

  def play
    until @board.solved?
      @board.render
      prompt
      input = get_input
      if valid_input?(input)
        update_board(input)
      end
    end
    congrat
  end
end

if __FILE__ == $PROGRAM_NAME
  puzzle = gets.chomp
  Sudoku.new(puzzle).play
end
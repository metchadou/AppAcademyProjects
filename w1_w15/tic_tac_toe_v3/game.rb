require_relative "board.rb"
require_relative "human_player.rb"
require_relative "computer_player.rb"

class Game
  def initialize(n, marks)
    @board = Board.new(n)
    @players = []
    marks.each do |mark, boolean|
      if boolean
        @players << ComputerPlayer.new(mark)
      else
        @players << HumanPlayer.new(mark)
      end
    end
    @current_player = @players.first
  end

  def switch_turn
    @players.rotate!
    @current_player = @players.first
  end

  def play
    while @board.empty_positions?
      @board.print
      position = @current_player.get_position(@board.legal_positions)
      mark = @current_player.mark
      @board.place_mark(position, mark)
      if @board.win?(mark)
        @board.print
        puts "Player #{mark} has WON !"
        return
      else
        self.switch_turn
      end
    end
    @board.print
    puts "DRAW"
  end
end
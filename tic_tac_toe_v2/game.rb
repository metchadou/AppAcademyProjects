require_relative "board.rb"
require_relative "human_player.rb"

class Game
  def initialize(n, *marks)
    @board = Board.new(n)
    @players = []
    marks.each {|m| @players << HumanPlayer.new(m)}
    @current_player = @players.first
  end

  def switch_turn
    @players.rotate!
    @current_player = @players.first
  end

  def play
    while @board.empty_positions?
      @board.print
      position = @current_player.get_position
      mark = @current_player.mark
      @board.place_mark(position, mark)
      if @board.win?(mark)
        puts "Player #{mark} has WON !"
        return
      else
        self.switch_turn
      end
    end
    puts "DRAW"
  end
end
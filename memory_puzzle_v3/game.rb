require 'byebug'
require_relative 'card.rb'
require_relative 'board.rb'
require_relative 'human_player.rb'
require_relative 'computer_player.rb'

class Game
  attr_reader :board
  def initialize(size, player = "ai")
    @board = Board.new(size)
    @previous_guess = nil
    @player = HumanPlayer.new
    @player = ComputerPlayer.new(size) if player.downcase == "ai"
  end

  def over?(turns)
    @board.won? || 
    @board.revealed_bomb? || 
    reached_turns_limit?(turns)
  end

  def pause
    sleep(1)
  end

  def match_screen
    @board.refresh
    puts "It's a match"
    self.pause
  end

  def mismatch_screen
    @board.refresh
    puts "Sorry, no match"
    self.pause
  end

  def first_guess?
    @previous_guess == nil
  end

  def update_previous_guess(new_val)
    @previous_guess = new_val
  end

  def make_guess(guessed_pos)
    guessed_card = @board.reveal(guessed_pos)
    if !guessed_card.is_bomb?
      @player.receive_revealed_card(guessed_pos, guessed_card.value)
      if self.first_guess?
        self.update_previous_guess(guessed_pos)
      else
        if @board[@previous_guess] == guessed_card
          self.match_screen
          @player.receive_match(@previous_guess, guessed_pos)
        else
          self.mismatch_screen
          [@board[@previous_guess], guessed_card].each {|card| card.hide}
        end
        self.update_previous_guess(nil)
      end
    end
  end

  def play_turn
    @player.prompt
    self.make_guess(@player.get_input)
  end

  def turn_limit
    @board.size ** 2
  end

  def reached_turns_limit?(turns)
    turns > turn_limit
  end

  def run
    @board.populate
    @board.show_bombs
    turns = 0
    until self.over?(turns)
      @board.refresh
      puts "Guesses : #{turns}"
      puts "Max guesses allowed : #{turn_limit}"
      play_turn
      turns += 1 if first_guess?
    end
    @board.reveal_bombs
    @board.refresh
    if @board.won?
      @player.congrat
    else
      @player.encourage
    end
  end
  
end

if __FILE__ == $PROGRAM_NAME
  puts "Enter the game size :"
  size = Integer(gets.chomp)
  size += 1 if size.odd?
  puts "Enter the player name :"
  player_name = gets.chomp
  Game.new(size, player_name).run
end
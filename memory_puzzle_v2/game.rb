require 'byebug'
require_relative 'card.rb'
require_relative 'board.rb'
require_relative 'human_player.rb'
require_relative 'computer_player.rb'

class Game
  attr_reader :board
  def initialize(player = "ai")
    @board = Board.new
    @previous_guess = nil
    @player = HumanPlayer.new

    @player = ComputerPlayer.new if player.downcase == "ai"
  end

  def over?
    @board.won?
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

  def play
    @board.populate
    until self.over?
      @board.refresh
      @player.prompt
      self.make_guess(@player.get_input)
    end
    @player.congrat
  end
  
end
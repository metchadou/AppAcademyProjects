require 'byebug'
require_relative 'card.rb'
require_relative 'board.rb'

class Game
  attr_reader :board
  def initialize
    @board = Board.new
    @previous_guess = nil
  end

  def over?
    @board.won?
  end

  def prompt
    puts "Please enter the position of the card you'd like to flip (e.g., '2,3')"
  end

  def refresh
    
  end

  def match_screen
    @board.refresh
    puts "It's a match"
    sleep(1)
  end

  def mismatch_screen
    @board.refresh
    puts "Sorry, no match"
    sleep(1)
  end

  def checking_new_card?
    @previous_guess == nil
  end

  def make_guess(guessed_pos)
    guessed_card = @board[guessed_pos]
    guessed_card.reveal
    if self.checking_new_card?
      @previous_guess = guessed_card
    else
      if @previous_guess == guessed_card
        self.match_screen
      else
        self.mismatch_screen
        [@previous_guess, guessed_card].each {|card| card.hide}
      end
      @previous_guess = nil
    end
  end

  def congrat
    puts "YOU WON !!!"
  end

  def get_input
    gets.chomp.split(",").map(&:to_i)
  end

  def play
    @board.populate
    until self.over?
      @board.refresh
      self.prompt
      self.make_guess(self.get_input)
    end
    self.congrat
  end
  
end
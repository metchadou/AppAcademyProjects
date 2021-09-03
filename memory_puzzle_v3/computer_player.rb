require "byebug"
require_relative "game.rb"

class ComputerPlayer

  attr_reader :known_cards, :matched_cards, :previous_guess
  def initialize(size)
    @known_cards = {}
    @matched_cards = []
    @previous_guess = nil
    @size = size
  end

  def receive_revealed_card(pos, val)
    @known_cards[pos] = val
  end

  def receive_match(pos1, pos2)
    @matched_cards << [pos1, pos2]
  end

  # TODO modify to include @matched_cards.has_value? and @matched_cards.has_key?
  def seen_card?(card)
    return true if @known_cards.has_key?(card)
    false
  end

  def all_positions
    (0...@size).to_a.repeated_permutation(2).to_a
  end

  def unseen_cards
    cards = self.all_positions
    cards.reject {|card| seen_card?(card)}
  end

  def random_guess
    self.unseen_cards.sample
  end

  # Count cards values in @known_cards to see if there are two cards with same value
  def values_count
    count = Hash.new(0)
    @known_cards.each_value {|val| count[val] += 1}
    count
  end

  # Checks if a card has already been matched
  def already_matched?(cards_pair)
    @matched_cards.include?(cards_pair) || 
    @matched_cards.include?(cards_pair.reverse)
  end

  # returns two matching cards
  def matching_cards
    values = self.values_count.select {|cd, occ| occ == 2}.keys # put it in its own a method
    return nil if values.empty?
    values.each do |val|
      cards = @known_cards.select {|pos, v| v == val}.keys
      return cards if !self.already_matched?(cards)
    end
    nil
  end

  def first_guess
    guess = self.matching_cards
    if guess == nil
      guess = self.random_guess
      @previous_guess = guess
      return guess
    end
    @previous_guess = guess.sample
  end

  def second_guess
    guess = self.random_guess
    prev_guess_val = @known_cards[@previous_guess]
    @known_cards.each do |pos, val|
      guess = pos if prev_guess_val == val && pos != @previous_guess # put in a methosd
    end
    @previous_guess = nil
    guess
  end

  def first_guess?
    @previous_guess == nil
  end

  def guess
    if self.first_guess?
      return self.first_guess
    else
      return self.second_guess
    end
  end

  def get_input
    self.guess
  end

  def prompt
    puts "Please enter the position of the card you'd like to flip (e.g., '2,3')"
  end

  def congrat
    puts "YOU WON !"
  end
  
  def encourage
    puts "Sorry, You lost. You will make it next time !"
  end
end
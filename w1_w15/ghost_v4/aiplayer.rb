require "byebug"

class AiPlayer
  
  attr_reader :name

  def initialize(name)
    @name = name.capitalize
  end

  def possible_moves(dictionary, fragment)
    moves = []
    alpha = ("a".."z").to_a
    alpha.each do |letter|
      move = fragment + letter
      dictionary.each_key do |word|
        moves << letter if word.start_with?(move)
      end
    end
    moves
  end

  def best_move(dictionary, fragment, n)
    counts = Hash.new(0)
    candidates = self.possible_moves(dictionary, fragment)
    candidates.each do |candidate|
      possible_word = fragment + candidate
      length_limit = possible_word.length + n
      dictionary.each do |word, length|
        if !dictionary.include?(possible_word)
          if (word.start_with?(possible_word) && length <= length_limit)
            counts[candidate] += 1
          end
        end
      end
    end
    move = counts.max_by {|letter, winners| winners}
    move.first
  end

  def ai_guess(dictionary, fragment, n)
    self.best_move(dictionary, fragment, n)
  end

  def alert_invalid_guess
    puts "Invalid play. #{self.name.capitalize} please enter a valid letter"
  end
end
require "byebug"

class AiPlayer
  
  attr_reader :name

  def initialize(name)
    @name = name.capitalize
  end

  def losing_moves(dictionary, fragment)
    losers = []
    alpha = ("a".."z").to_a
    alpha.each do |letter|
      move = fragment + letter
      dictionary.each_key do |word|
        losers << letter if word.start_with?(move)
      end
    end
    losers
  end

  def winning_moves(dictionary, fragment, n)
    winners = []
    alpha = ("a".."z").to_a
    alpha.each do |letter|
      move = fragment + letter
      length_limit = move.length + n
      dictionary.each do |word, length|
        if !dictionary.include?(move)
          winners << letter if (word.start_with?(move) && length <= length_limit)
        end
      end
    end
    winners
  end

  def ai_guess(dictionary, fragment, n)
    winners = self.winning_moves(dictionary, fragment, n)
    losers = self.losing_moves(dictionary, fragment)

    winners.each {|winner| winners.delete(winner) if losers.include?(winner)}

    winners.empty? ? losers.sample : winners.sample
  end

  def alert_invalid_guess
    puts "Invalid play. #{self.name.capitalize} please enter a valid letter"
  end
end
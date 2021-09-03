require_relative "player.rb"
require "byebug"

class Game
  attr_reader :fragment
  def initialize(*players)
    @players = []
    players.each {|player| @players << Player.new(player)}
    @fragment = ""
    @losses = Hash.new(0)
    @dictionary = {}
    File.open("./dictionary.txt") do |fp|
      fp.each do |line|
        word = line.chomp
        @dictionary[word] = word.length
      end
    end
  end

  def current_player
    @players.first
  end

  def previous_player
    @players.last
  end

  def next_player!
    @players.rotate!
  end

  def valid_play?(string) # string = a
    alphabet = ("a".."z").to_a
    return false if !alphabet.include?(string.downcase)

    @dictionary.each_key {|word| return true if word.start_with?(@fragment+string.downcase)}

    false
  end

  def take_turn(player)
    puts "#{player.name}, it's your turn"

    play = player.guess
    while !valid_play?(play)
      player.alert_invalid_guess
      play = player.guess
    end

    @fragment += play.downcase
    if @dictionary.has_key?(@fragment)
      puts ""
      puts "'#{@fragment}' is an existing word in the dictionary, #{player.name} lose this round"
      @losses[player] += 1
      @fragment = ""
    end
  end

  def play_round
    player = self.current_player
    self.take_turn(player)
    self.next_player!
  end

  def record(player)
    ghost_word = "GHOST"
    losses = @losses[player]
    ghost_word.split("").take(losses).join("")
  end

  def display_standings
    @players.each do |player|
      puts "#{player.name} : #{self.record(player)}"
    end
    puts "WORD : #{@fragment}"
  end

  def run
    while @players.length > 1
      self.display_standings
      puts ""
      self.play_round
      puts "-------------"
      @losses.each do |player, loss|
        @players.delete(player) if loss == 5
      end
    end
    puts "CONGRATULATIONS #{@players.first.name}, YOU WON"
  end

end
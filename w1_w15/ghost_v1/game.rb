require_relative "player.rb"
require "byebug"

class Game
  attr_reader :fragment
  def initialize(player1_name, player2_name)
    player1 = Player.new(player1_name)
    player2 = Player.new(player2_name)
    @players = [player1, player2]
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
    @players[0]
  end

  def previous_player
    @players[1]
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
    puts "#{self.current_player.name} : #{self.record(self.current_player)}"

    puts "#{self.previous_player.name} : #{self.record(self.previous_player)}"

    puts "Word : #{@fragment}"
  end

  def run
    current_player_record = self.record(self.current_player)

    while current_player_record != "GHOST"
      self.display_standings
      puts ""
      self.play_round
      puts "-------------"
      previous_player_record = self.record(self.previous_player)
      if previous_player_record == "GHOST"
        puts "CONGRATULATIONS #{self.current_player.name}, YOU WON"
        break
      end
    end
  end

end 
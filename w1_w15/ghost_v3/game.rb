require_relative "player.rb"
require_relative "aiplayer.rb"
require "byebug"

class Game
  def initialize(players)
    @categories = {}
    players.each do |player, category|
      if category
        @categories[AiPlayer.new(player)] = category
      else
        @categories[Player.new(player)] = category
      end
    end
    @players = @categories.keys
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

  def valid_play?(string)
    alphabet = ("a".."z").to_a
    return false if !alphabet.include?(string.downcase)

    @dictionary.each_key {|word| return true if word.start_with?(@fragment+string.downcase)}

    false
  end

  def take_turn(player)
    puts "#{player.name}, it's your turn"
    if @categories[player]
      n = @players.length - 1
      play = player.ai_guess(@dictionary, @fragment, n)
      puts "#{play}"
    else
      play = player.guess
    end

    while !valid_play?(play)
      player.alert_invalid_guess
      if @categories[player]
        n = @players.length - 1
        play = player.ai_guess(@dictionary, @fragment, n)
        puts "#{play}"
      else
        play = player.guess
      end
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
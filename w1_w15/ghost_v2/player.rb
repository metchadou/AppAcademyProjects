class Player
  attr_reader :name

  def initialize(name)
    @name = name.capitalize
  end

  def guess
    gets.chomp
  end

  def alert_invalid_guess
    puts "Invalid play. #{self.name.capitalize} please enter a valid letter"
  end
end
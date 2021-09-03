class Board

  def self.print_grid(grid)
    i = 0
    while i < grid.length
      puts grid[i].join(" ")
      i += 1
    end
  end

  attr_reader :size

  def initialize(n)
    @grid = Array.new(n) { Array.new(n, :N)}
    @size = n * n
  end

  def [](position)
    row, col = position
    @grid[row][col]
  end

  def []=(position, val)
    row, col = position
    @grid[row][col] = val
  end

  def num_ships
    count = 0
      i = 0
      while i < @grid.length
        count += @grid[i].count(:S)
        i += 1
      end
    count
  end

  def attack(position)
    
    if self[position] == :S
      self[position] = :H
      puts "youn sunk my battleship!"
      return true
    else
      self[position] = :X
      return false
    end
  end

  def place_random_ships
    percentage = @size * 0.25
    n = Math.sqrt(@size)

    while self.num_ships < percentage
      row = rand(0...n)
      col = rand(0...n)
      position = [row, col]
      self[position] = :S
    end
  end

  def hidden_ships_grid
    new_grid = []
    i = 0
    while i < @grid.length
      temp = []
      @grid[i].each do |ele|
        if ele == :S
          ele = :N
          temp << ele
        else
          temp << ele
        end
      end

      new_grid << temp
      i += 1
    end

    new_grid
  end

  def cheat
    Board.print_grid(@grid)
  end

  def print
    Board.print_grid(self.hidden_ships_grid)
  end
end
class Maze
  
  attr_accessor :maze
  def initialize(file)
    f = File.open(file)
    arr = f.readlines
    @maze = arr.map do |a|
      a = a.split("")
      a.delete("\r")
      a.delete("\n")
      a
    end
  end

  def starting_point
    (0...@maze.length).each do |y|
      (0...@maze.first.length).each do |x|
        if @maze[y][x] == "S"
          return [y, x]
        end
      end
    end
    point
  end

  def ending_point
    (0...@maze.length).each do |y|
      (0...@maze.first.length).each do |x|
        if @maze[y][x] == "E"
          return [y, x]
        end
      end
    end
  end

  def length
    @maze.length
  end

  def [](index)
    @maze[index]
  end

  def first
    @maze.first
  end

end
require "byebug"
class MazeSolver

  attr_reader :current_position, :maze
  def initialize(maze)
    @maze = []
    f = File.open(maze)
    arr = f.readlines
    arr.each do |a|
      new_arr = a.split("")
      new_arr.delete("\r")
      new_arr.delete("\n")
      @maze << new_arr
    end

    @current_position = []
    (0...@maze.length).each do |y|
      (0...@maze.first.length).each do |x|
        @current_position = [y, x] if @maze[y][x] == "S"
      end
    end
  end

  def solve_maze
    until self.reached_exit?
      self.find_path
    end
    puts "maze solved"
  end

  # helper methods
  def reached_exit?
    directions = self.get_directions
    adjacent_locations = directions.values
    adjacent_locations.one? do |loc|
      y = loc[0]
      x = loc[1]
      bool = @maze[y][x] == "E"
      bool
    end
  end

  def find_path
    best_move = self.best_moves.keys.first
    random_legal_move = self.legal_moves.keys.sample

    if best_move
      until self.hit_wall_or_exit?(best_move)
        directions = self.get_directions
        move = directions[best_move]
        y = move[0]
        x = move[1]
        @maze[y][x] = "X" 
        self.update_current_position(move)
      end
    else
      until self.hit_wall_or_exit?(random_legal_move)
        directions = self.get_directions
        move = directions[random_legal_move]
        y = move[0]
        x = move[1]
        @maze[y][x] = "X" 
        self.update_current_position(move)
      end
    end
  end

  def hit_wall_or_exit?(move)
    directions = self.get_directions
    location = directions[move]
    y = location[0]
    x = location[1]
    @maze[y][x] == "*" || @maze[y][x] == "E"
  end

  def best_moves
    moves = {}
    exit_geographical_position = self.get_geo_position(self.exit_location)

    self.legal_moves.each do |direction, location|
      moves[direction] = location if exit_geographical_position.include?(direction)
    end
    
    moves
  end

  def legal_moves
    moves = {}
    directions = self.get_directions

    directions.each do |direction, location|
      moves[direction] = location if self.is_walkable?(location)
    end

    moves
  end

  def get_directions
    directions = {
      "right" => [@current_position[0], @current_position[1] + 1],
      "left" => [@current_position[0], @current_position[1] - 1],
      "top" => [@current_position[0] - 1, @current_position[1]],
      "bottom" => [@current_position[0] + 1, @current_position[1]]
    }
  end

  def is_walkable?(location)
    y = location[0]
    x = location[1]
    @maze[y][x]== " "
  end

  def update_current_position(new_position)
    @current_position = new_position
  end

  def exit_location
    (0...@maze.length).each do |y|
      (0...@maze.first.length).each do |x|
        exit_loc = [y, x]
        return exit_loc if @maze[y][x] == "E"
      end
    end
  end

  def get_geo_position(position)
    horizontal_first_half = (@maze.length - 1) / 2
    vertical_first_half = (@maze.first.length - 1) / 2
    maze_top_area = (0..horizontal_first_half).to_a
    maze_bottom_area = (horizontal_first_half + 1..@maze.length - 1).to_a
    maze_left_area = (0..vertical_first_half).to_a
    maze_right_area = (vertical_first_half + 1..@maze.first.length - 1).to_a

    y = position[0]
    x = position[1]

    if maze_top_area.include?(y) && maze_left_area.include?(x)
      return ["top", "left"]
    elsif maze_bottom_area.include?(y) && maze_left_area.include?(x)
      return ["bottom", "left"]
    elsif maze_top_area.include?(y) && maze_right_area.include?(x)
      return ["top", "right"]
    elsif maze_bottom_area.include?(y) && maze_right_area.include?(x)
      return ["bottom", "right"]
    end
  end

  # display maze

  def print
    @maze.each {|arr| p arr}
  end
end
# def move
#   best_move = self.best_moves.first
#   random_legal_move = self.legal_moves.values.sample

#   if best_move
#     y = best_move[0]
#     x = best_move[1]
#     @maze[y][x] = "X"
#     self.update_current_position(best_move)
#   else
#     y = random_legal_move[0]
#     x = random_legal_move[1]
#     @maze[y][x] = "X"
#     self.update_current_position(random_legal_move)
#   end
# end


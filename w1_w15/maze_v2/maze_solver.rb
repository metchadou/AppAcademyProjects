require "byebug"
require_relative "maze.rb"

class MazeSolver

  ORTHOGONAL_MOVE_COST = 10
  DIAGONAL_MOVE_COST = 14

  attr_reader :current_node, :open_list, :closed_list, :starting_point, :parents, :maze, :ending_point

  def initialize(file)
    @maze = Maze.new(file)
    @starting_point = @maze.starting_point
    @ending_point = @maze.ending_point
    @closed_list = []
    @open_list = []
    @parents = Hash.new {|h, k| h[k] = []}
    @scores = {}
  end

  def search_shortest_path
    self.add_to_open_list(@starting_point)

    until self.is_on_closed_list?(@ending_point)
      @current_node = self.lowest_f_node

      self.switch_to_closed_list(@current_node)

      self.adjacent_nodes(@current_node).each do |node|
        if self.is_walkable?(node) && !self.is_on_closed_list?(node)
          if is_on_open_list?(node)
            if self.is_better_path?(@current_node, node)
              self.change_parent(node, @current_node)
            end
          else
            self.add_to_open_list(node)
            self.save_as_parent(node, @current_node)
            self.record_scores(node)
          end
        end
      end
    end

    self.save_and_mark_path
  end

  # HELPER METHODS

  def save_and_mark_path
    path = []

    # saving path
    until @current_node == @starting_point
      @parents.each do |parent, nodes|
        if nodes.include?(@current_node)
          path << parent
          @current_node = parent
          break
        end
      end
    end

    # marking path
    path.each do |spot|
      y = spot[0]
      x = spot[1]
      @maze[y][x] = "X" unless spot == @starting_point
    end
  end

  def is_better_path?(current_node, adjacent_node)
    adjacent_node_scores = @scores[adjacent_node]
    old_path_g = adjacent_node_scores[1]

    if current_node == @starting_point
      current_node_g = 0
    else
      current_node_scores = @scores[current_node]
      current_node_g = current_node_scores[1]
    end

    if self.are_diagonal?(current_node, adjacent_node)
      new_path_g = current_node_g + DIAGONAL_MOVE_COST
    else
      new_path_g = current_node_g + ORTHOGONAL_MOVE_COST
    end

    new_path_g < old_path_g
  end

  def are_diagonal?(node1, node2)
    self.diagonally_adjacent_nodes(node1).include?(node2)
  end

  def record_scores(node)
    f = self.get_f_cost(node)
    g = self.get_g_cost(node)
    h = self.get_h_cost(node)

    @scores[node] = [f, g, h]
  end

  def lowest_f_node
    f_scores = Hash.new(0)

    @open_list.each do |node|
      f = self.get_f_cost(node)
      f_scores[node] = f
    end

    f_scores.key(f_scores.values.min)
  end

  def get_f_cost(node)
    g = self.get_g_cost(node)
    h = self.get_h_cost(node)
  
    g + h
  end

  def get_h_cost(node)
    y = node[0]
    x = node[1]
    b = @ending_point[0]
    a = @ending_point[1]

    total_vertical_nodes = (b - y).abs
    total_horizontal_nodes = (a - x).abs
    total_nodes = total_vertical_nodes + total_horizontal_nodes

    total_nodes  * 10
  end

  def get_g_cost(node)
    return 0 if node == @starting_point
    
    @parents.each do |parent, nodes|
      if nodes.include?(node)
        node_is_diagonal = self.diagonally_adjacent_nodes(parent).include?(node)

        if node_is_diagonal
          return self.get_g_cost(parent) + DIAGONAL_MOVE_COST
        else
          return self.get_g_cost(parent) + ORTHOGONAL_MOVE_COST
        end
      end
    end
    nil
  end

  def is_on_closed_list?(node)
    @closed_list.include?(node)
  end

  def is_on_open_list?(node)
    @open_list.include?(node)
  end

  def switch_to_closed_list(node)
    self.drop_from_open_list(node)
    self.add_to_closed_list(node)
  end

  def drop_from_open_list(node)
    @open_list.delete(node)
  end

  def add_to_closed_list(node)
    @closed_list << node
  end

  def add_to_open_list(node)
    @open_list << node
  end

  def change_parent(adjacent_node, new_parent)
    @parents.each do |parent, nodes|
      nodes.delete(adjacent_node) if nodes.include?(adjacent_node)
    end
    @parents[new_parent] << adjacent_node
  end
  
  def save_as_parent(node, parent)
    @parents[parent] << node unless self.has_parent?(node)
  end

  def has_parent?(node)
    @parents.each_value do |nodes|
      return true if nodes.include?(node)
    end
    false
  end

  def is_walkable?(node)
    y = node[0]
    x = node[1]
    @maze[y][x] != "*"
  end

  def adjacent_nodes(node)
    vertical_nodes = self.vertically_adjacent_nodes(node)
    horizontal_nodes = self.horizontally_adjacent_nodes(node)
    diagonal_nodes = self.diagonally_adjacent_nodes(node)
    
    [*vertical_nodes, *horizontal_nodes, *diagonal_nodes]
  end

  def vertically_adjacent_nodes(node)
    nodes = []
    y = node[0]
    x = node[1]

    (0...@maze.length).each do |y1|
      (0...@maze.first.length).each do |x1|
        if (y1 == y-1 && x1 == x) || (y1 == y+1 && x1 == x)
          nodes << [y1,x1]
        end
      end
    end

    nodes
  end

  def horizontally_adjacent_nodes(node)
    nodes = []
    y = node[0]
    x = node[1]
    
    (0...@maze.length).each do |y1|
      (0...@maze.first.length).each do |x1|
        if (x1 == x-1 && y1 == y) || (x1 == x+1 && y1 == y)
          nodes << [y1,x1]
        end
      end
    end

    nodes
  end

  def diagonally_adjacent_nodes(node)
    nodes = []
    y = node[0]
    x = node[1]

    (0...@maze.length).each do |y1|
      (0...@maze.first.length).each do |x1|
        if (y1 == y-1 && x1 == x-1) || (y1 == y-1 && x1 == x+1)
          nodes << [y1,x1]
        elsif (y1 == y+1 && x1 == x-1) || (y1 == y+1 && x1 == x+1)
          nodes << [y1,x1]
        end
      end
    end

    nodes
  end

  def print
    p @maze
  end
end
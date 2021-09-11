require "byebug"
require_relative "chessboard"
require_relative "polytreenode"

class KnightPathFinder

  attr_reader :root_node
  def self.valid_moves(pos)
    ChessBoard.knight_valid_moves(pos)
  end
  
  def initialize(start_pos)
    @root_node = PolyTreeNode.new(start_pos)
    @considered_pos = [start_pos]

    build_move_tree
  end

  def new_move_positions(pos)
    positions = []

    KnightPathFinder.valid_moves(pos).each do |move|
      unless @considered_pos.include?(move)
        positions << move
        @considered_pos << move
      end
    end

    positions
  end

  def build_move_tree
    nodes = [@root_node]

    until nodes.empty?
      node = nodes.shift
      children = new_move_positions(node.value).map {|pos| PolyTreeNode.new(pos)}
      
      children.each do |child|
        node.add_child(child)
        nodes << child
      end
    end
  end

end
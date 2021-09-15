require "byebug"
class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @player1, @player2 = name1, name2
    @cups = Array.new(14) {Array.new}

    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    @cups.each_with_index do |cup, i|
      next if i == 6 || i == 13

      4.times { cup << :stone }
    end
  end

  def valid_move?(start_pos)
    raise 'Invalid starting cup' unless start_pos.between?(0, cups.length-1)
    raise 'Starting cup is empty' if cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
    nber_stones = cups[start_pos].length
    cups[start_pos] = []

    idx = start_pos
    opponent_points_cup = current_player_name == @player1 ? 13 : 6
    until nber_stones == 0
      idx += 1
      idx = 0 if idx > cups.length-1

      unless idx == opponent_points_cup
        cups[idx] << :stone
        nber_stones -= 1
      end
    end

    render
    next_turn(idx)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    ending_cup = cups[ending_cup_idx]

    if ending_cup_idx == 6 || ending_cup_idx == 13
      :prompt
    elsif ending_cup.length == 1
      :switch
    else
      ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    sides = [(0..5).to_a, (7..12).to_a]

    sides.any? do |side|
      side.all? {|i| cups[i] == []}
    end
  end

  def winner
    case cups[6].length <=> cups[13].length
    when 1
      @player1
    when -1
      @player2
    when 0
      :draw
    end
  end
end

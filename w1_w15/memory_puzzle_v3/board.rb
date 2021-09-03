require 'byebug'
require_relative 'card.rb'
class Board
  def initialize(size)
    @grid = Array.new(size) {Array.new(size)}
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end

  def size
    @grid.length
  end

  # returns positions on the board containing no card
  def empty
    pos = []
    (0...@grid.length).each do |row_i|
      (0...@grid.length).each do |col_i|
        pos << [row_i, col_i] if self[[row_i, col_i]] == nil
      end
    end
    pos
  end

  # generates cards
  def normal_cards
    alphanums = ("A".."Z").to_a + (0..9).to_a
    vals = [] 
    alphanums.sample(((size*size)-size) / 2).cycle(2) {|ch| vals << ch}
    vals.map {|val| Card.new(val)}
  end

  def bombs
    bombs = ["*"] * size
    bombs.map {|bomb| Card.new(bomb)}
  end

  def cards
    [*normal_cards, *bombs]
  end

  def revealed
    cards = []
    (0...@grid.length).each do |row|
      (0...@grid.length).each do |col|
        card = self[[row, col]]
        cards << card if card.face_up == true
      end
    end
    cards
  end

  def revealed_bomb?
    revealed.any? {|card| card.is_bomb?}
  end

  def reveal_bombs
    (0...size).each do |row|
      (0...size).each do |col|
        pos = [row, col]
        card = self[pos]
        reveal(pos) if card.is_bomb?
      end
    end
  end

  def hide_bombs
    (0...size).each do |row|
      (0...size).each do |col|
        pos = [row, col]
        card = self[pos]
        hide(pos) if card.is_bomb?
      end
    end
  end

  # populates the board with generated cards
  def populate
    cds = self.cards.shuffle
    until self.empty.empty?
      pos = self.empty.sample
      self[pos] = cds.pop
    end
    true
  end

  # prints out board's current state
  def render
    count = -1
    disp = @grid.map {|r| [count += 1] + r.map {|c| c.display}}
    disp.unshift([" "] + (0...size).to_a)
    disp.each {|r| puts r.join(" ")}
  end

  def show_bombs
    system('clear')
    reveal_bombs
    render
    sleep(5)
    hide_bombs
  end

  # refresh board
  def refresh
    system('clear')
    render
  end

  # checks for win
  def won?
    nber_normal_cards = normal_cards.length
    count = 0 # count the nber of normal cards revealed
    revealed.each do |card|
      if !card.is_bomb? && card.face_up
        count += 1
      end
    end
    count == nber_normal_cards
  end

  # reveal card
  def reveal(pos)
    unless self[pos].face_up
      self[pos].reveal
      return self[pos]
    end
  end

  def hide(pos)
    if self[pos].face_up
      self[pos].hide
      return self[pos]
    end
  end

end
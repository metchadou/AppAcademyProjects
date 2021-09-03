require 'byebug'
require_relative 'card.rb'
class Board
  def initialize
    @grid = Array.new(4) {Array.new(4)}
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
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
  def cards
    alphanums = ("A".."Z").to_a + (0..9).to_a
    vals = []
    alphanums.sample(8).cycle(2) {|ch| vals << ch}
    vals.map {|val| Card.new(val)}
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
    disp.unshift([" "] + (0..3).to_a)
    disp.each {|r| puts r.join(" ")}
  end

  # refresh board
  def refresh
    system('clear')
    self.render
  end

  # checks for win
  def won?
    @grid.all? {|row| row.all? {|c| c.face_up}}
  end

  # reveal card
  def reveal(guessed_pos)
    unless self[guessed_pos].face_up
      self[guessed_pos].reveal
      return self[guessed_pos]
    end
  end

end
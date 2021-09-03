class Board
  def initialize
    @grid = Array.new(3) { ['_'] * 3 }
  end

  def valid?(position)
    row = position[0]
    col = position[1]
    nber_of_rows = @grid.length
    nber_of_cols = @grid.first.length

    row < nber_of_rows && col < nber_of_cols
  end

  def empty?(position)
    row = position[0]
    col = position[1]
    
    @grid[row][col] == '_'
  end

  def place_mark(position, mark)
    if self.valid?(position) && self.empty?(position)
      row = position[0]
      col = position[1]

      @grid[row][col] = mark
    else
      raise "Invalid mark"
    end
  end

  def print
    @grid.each { |row| p row }
  end

  def win_row?(mark)
    @grid.any? { |row| row.all? { |m| m == mark } }
  end

  def win_col?(mark)
    (0...@grid.first.length).any? do |i_col|
      (0...@grid.length).all? do |i_row|
        @grid[i_row][i_col] == mark
      end
    end
  end

  def win_diagonal?(mark)
    indices = (0...@grid.length).to_a
    
    win_first_diag = indices.all? {|i| @grid[i][i] == mark}
    win_second_diag = indices.all? {|i| @grid.reverse[i][i] == mark}

    win_first_diag || win_second_diag
  end

  def win?(mark)
    return true if win_row?(mark)
    return true if win_col?(mark)
    return true if win_diagonal?(mark)

    false
  end

  def empty_positions?
    (0...@grid.length).any? do |row|
      (0...@grid.first.length).any? do |col|
        @grid[row][col] == '_'
      end
    end
  end
end 
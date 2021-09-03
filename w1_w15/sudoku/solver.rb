require "byebug"
require_relative "tile.rb"
require_relative "board.rb"

class SudokuSolver
  SUDOKU_DIGITS = (1..9).to_a
  
  def initialize(sudoku_file)
    @board = Board.new(sudoku_file)
    @current_cell = first_cell
  end

  def print_board
    @board.render
  end

  def tile(cell)
    @board[cell]
  end

  def non_given_cells
    cells = []
    (0...@board.size).each do |row_i|
      (0...@board.size).each do |col_i|
        cell = [row_i, col_i]
        cells << cell unless tile(cell).given?
      end
    end
    cells
  end

  def first_cell # first non given cell
    non_given_cells.first
  end

  def last_cell # last non given cell
    non_given_cells.last
  end

  def advance
    current_cell_idx = non_given_cells.index(@current_cell)
    next_cell_idx = current_cell_idx + 1
    next_cell = non_given_cells[next_cell_idx]
    @current_cell = next_cell
  end

  def move_back
    current_cell_idx = non_given_cells.index(@current_cell)
    previous_cell_idx = current_cell_idx - 1
    previous_cell = non_given_cells[previous_cell_idx]
    @current_cell = previous_cell
  end

  def place_digit(digit, cell)
    tile(cell).write(digit)
  end

  def test_digit(digit, cell)
    tile(cell).draft(digit)
  end
  
  def leave_blank(cell)
    tile(cell).erase
    tile(cell).previous_value = 0
  end

  def row(cell) # gets row of a given cell
    row_i = cell.first
    @board.rows[row_i]
  end

  def column(cell) # gets column of a given cell
    col_i = cell.last
    @board.columns[col_i]
  end

  def box(cell) # gets box of a given cell
    @board.boxes.find do |box|
      box.include?(tile(cell))
    end
  end

  def violate?(digit, cell) # checks if a digit put in a cell violates a row, a cell or a box
    test_digit(digit, cell)
    row_col_box = [row(cell), column(cell), box(cell)]
    row_col_box.any? do |ary|
      digits = @board.to_i(ary) # convert tiles into their digit values
      digits.count(digit) > 1
    end
  end

  def filled_last_cell?
    SUDOKU_DIGITS.include?(tile(last_cell).value)
  end

  def allowed_digits(cell) # Digits that do not violate any sudoku rule. Don't always solve the puzzle
    SUDOKU_DIGITS.select do |digit|
      !violate?(digit, cell)
    end
  end

  def valid_digit(cell, digits) # An allowed digit that solves the puzzle
    prev_val = previous_val(cell)
    digit = digits.find(->{digits.first}) do |dgt|
      dgt > previous_val(@current_cell)
    end
    digit == prev_val ? nil : digit
  end

  def previous_val(cell)
    tile(cell).previous_value
  end

  def solve
    until @board.solved?
      allowed_digits = allowed_digits(@current_cell)
      valid_dgt = valid_digit(@current_cell, allowed_digits)
      if !valid_dgt
        leave_blank(@current_cell)
        move_back
      else
        place_digit(valid_dgt, @current_cell)
        advance
      end
    end
  end

end
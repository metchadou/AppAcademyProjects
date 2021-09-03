require "byebug"

module EightQueensClasses

  class ChessBoard

    attr_accessor :board
    def initialize
      @board = Array.new(8) { Array.new(8,"-")}
    end

    def length
      @board.length
    end

    def place_queen(pos)
      y, x = pos
      @board[y][x] = "Q"
    end

    def in_board?(pos)
      x, y = pos
      if @board[y] == nil
        return false
      elsif @board[y][x] == nil
        return false
      end
      true
    end

    def rows
      @board
    end

    def columns
      cols = []
      n = @board.length
      (0...n).each do |x|
        col = []
        (0...n).each do |y|
          col << @board[y][x]
        end
        cols << col
      end
      cols
    end

    def reverses
      board1 = @board
      board2 = board1.reverse
      board3 = @board.map {|r| r.reverse}
      board4 = board3.reverse
      [board1, board2, board3, board4]
    end

    def diagonals
      diags = []
      boards = self.reverses
      boards.each do |b|
        n = b.length
        (0...n).each do |y|
          diag = []
          x = 0
          while self.in_board?([x, y])
            diag << b[y][x]
            x += 1
            y += 1
          end
          diags << diag
        end
      end
      diags
    end
    
  end

  # Eight Queens solver class
  class EightQueensSolver

    attr_reader :board
    def initialize
      @board = ChessBoard.new
    end
  
    def rows_solved?
      @board.rows.all? {|r| r.count("Q") == 1}
    end
  
    def columns_solved?
      @board.columns.all? {|col| col.count("Q") == 1}
    end
  
    def diagonals_solved?
      @board.diagonals.all? {|d| d.count("Q") < 2}
    end

    def is_solution?
      [self.rows_solved?, 
      self.columns_solved?,
      self.diagonals_solved?].all?
    end

    def solutions
      board_states = []
      n = @board.length
      x_indices = (0...n).to_a
      y_indices_perms = (0...n).to_a.permutation
  
      y_indices_perms.each do |y_indices|
        board_state = y_indices.zip(x_indices)
        board_state.each do |indices|
          @board.place_queen(indices)
        end
        board_state = @board
        board_states << board_state if self.is_solution?
        @board = ChessBoard.new
      end
      board_states
    end

    def total_solutions
      self.solutions.length
    end

    def print_solution(solution)
      solution.board.each {|line| puts line.join(" ")}
    end
  
    def solve
      puts "Number of solutions : #{self.total_solutions}\n"
      puts "Enter the number of solutions you want to see :\n"
      num = gets.chomp.to_i
      slts = self.solutions.take(num)
      slts.each do |slt|
        self.print_solution(slt)
        puts "****************"
      end
    end
  end
end

#tests

if __FILE__ == $PROGRAM_NAME
  test_solver = EightQueensClasses::EightQueensSolver.new
  test_solver.solve
end
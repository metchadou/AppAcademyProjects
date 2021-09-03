require "byebug"
require_relative 'tile.rb'

class Board

  NUMBERS = (1..9).to_a
  
  def self.from_file(file)
    f = File.open(file)
    grid = f.readlines
    grid.map do |row|
      row = row.split("")
      row.delete("\n")
      row.map! {|num| Tile.new(num.to_i)}
    end
  end

  def initialize(grid)
    @grid = Board.from_file(grid)
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    tile = @grid[x][y]
    tile.write(value)
  end

  def size
    @grid.length
  end

  def box_size
    @grid.length / 3
  end

  def render
    print_count = 0
    col_indices = (0...size).each_slice(box_size)
                  .zip([" "] * box_size)
                  .flatten
    puts "    #{col_indices.join(" ")}"
    @grid.each_with_index do |row, j|
      new_row = []
      i = 0
      until i == size
        nums = row[i...i + box_size]
        if i == 0
          new_row += ["|"] + nums + ["|"]
        else
          new_row += nums + ["|"]
        end
        i += box_size
      end
      puts "#{j} #{new_row.join(" ")}"
      print_count += 1
      if print_count == box_size
        puts "  #{"- ". * new_row.length}"
        print_count = 0
      end
    end
    nil
  end

  def boxes
    bxs = []
    sections = @grid.each_slice(box_size).to_a
    sections.each do |section|
      i = 0
      while i < size
        bx = []
        section.each {|row| bx += row[i...i+box_size]}
        bxs << bx
        i += box_size
      end
    end
    bxs
  end

  def columns
    first_row = @grid.first
    other_rows = @grid[1..-1]
    first_row.zip(*other_rows)
  end

  def rows
    @grid
  end

  def to_i(ary)
    ary.map {|t| t.value}
  end

  def solved_set?(set)
    to_i(set).sort.eql?(NUMBERS)
  end

  def solved_rows?
    rows.all? {|row| solved_set?(row)}
  end

  def solved_columns?
    columns.all? {|col| solved_set?(col)}
  end

  def solved_boxes?
    boxes.all? {|box| solved_set?(box)}
  end

  def solved?
    [solved_rows?,
     solved_columns?,
     solved_boxes?].all?
  end

end
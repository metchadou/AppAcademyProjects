class ComputerPlayer
  attr_reader :mark

  def initialize(mark_value)
    @mark = mark_value
  end

  def get_position(legal_positions)
    entered_position = legal_positions.sample
    row = entered_position[0]
    col = entered_position[1]

    puts "Computer Player #{mark} chose the position [#{row}, #{col}]"

    entered_position
  end
end
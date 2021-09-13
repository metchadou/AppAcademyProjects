class ChessBoard

  SIZE = 8
  KNIGHT_DELTAS = [[2,1], [2,-1], [1,2], [-1,2], 
                  [-2,1], [-2,-1], [1,-2], [-1,-2]]

  def self.knight_valid_moves(pos)
    KNIGHT_DELTAS.map do |delta|
      [delta[0] + pos[0], delta[1] + pos[1]] # Potential valid move
    end.select do |move|
      move.none? {|idx| idx < 0 || idx > SIZE-1}
    end
  end

end
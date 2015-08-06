require_relative 'board.rb'
  SLIDE_DELTAS = [[1,1], [1,-1]]
  JUMP_DELTAS = [[2,2], [2,-2]


class Piece
  attr_accessor :pos, :type, :orientation, :board #orientation is 1, -1 or 0 for a king
  attr_reader :color

  def initialize(pos, board, color, orientation)
    @pos, @board, @color, @orientation = pos, board, color, orientation
    @type = :pawn
    place_piece
  end

  def inspect
    "Pos => #{self.pos} , Color => #{self.color}, Type => #{self.type} "
  end

  def move_diffs

  end

  def perform_slide

  end

  def perform_jump

  end

  def place_piece
    i,j = self.pos[0], self.pos[1]
    self.board[i,j] = self
  end




end

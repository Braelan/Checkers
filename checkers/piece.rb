require_relative 'board.rb'
require 'colorize'
require 'byebug'
# an array of deltas with slide and jump arrays
  DELTAS = [[1,1], [1,-1]]
  SYMBOLS = {:king => "K", :pawn =>"C"}
  TYPES = [:pawn, :king]


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
    deltas = DELTAS
    neg_deltas = DELTAS.map{ |slide| [slide[0]* -1, slide[1]] }
    return [deltas[0] + neg_deltas[0], deltas[1] + neg_deltas[1]]  if self.type == :king
    self.orientation == :up ? neg_deltas : deltas
  end

  def perform_slide?(delta)
      abs_pos = self.transform(delta)
       board[abs_pos[0], abs_pos[1]] == nil && on_board?(abs_pos) ? true : false
     # returns true or false
  end

  def perform_jump?(delta)
      potential = transform([delta[0]*2, delta[1]*2])
      enemy_pos= self.transform(delta)
      if enemy?(enemy_pos) && on_board?(potential)
         true if board[potential[0],potential[1]].nil?
      end
      false
     #return true or false
  end

  def place_piece
    i,j = self.pos[0], self.pos[1]
    self.board[i,j] = self
  end

  def enemy?(pos)
    i,j = pos[0], pos[1]

    !self.board[i,j].nil?  && self.board[i,j].color != self.color ? true : false

  end

  def transform(delta)
    [self.pos[0] + delta[0], self.pos[1] + delta[1]]
  end

  def on_board?(pos)
    pos[1].between?(0,7) && pos[0].between?(0,7)
  end

  def render
    symbol = SYMBOLS[self.type]
    return symbol.colorize(self.color)
    symbol
  end
end

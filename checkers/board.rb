class Board
  SIZE = 8
  attr_accessor :grid

  def initialize
    @grid = make_grid
  end


  def render
  end

  def make_grid
   Array.new(SIZE){Array.new(SIZE) }
  end

  def []= (*pos, piece)
    row, col = pos
    self.grid[row][col] = piece
  end

  def [] (*pos)
    row, col = pos
    self.grid[row][col]
  end
end

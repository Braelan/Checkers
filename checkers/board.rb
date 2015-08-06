class Board
  SIZE = 8
  BOARD_COLORS = [:light_white, :default]
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

  def render
    grid.each_with_index do |row, row_idx|
      row_strs = Array.new(3) {""}
        row.each_with_index do |cell, col_idx|
        symbol = !cell.nil? ? cell.render : " "
        odd = (row_idx + col_idx).odd?
        sym_str = "#{symbol}"
        row_strs[0] += format_str(" ", odd)
        row_strs[1] += format_str(sym_str, odd)
        row_strs[2] += format_str(" ", odd)
      end
      puts row_strs.join("\n")
    end
    nil
  end

  def format_str(str, alt)
    color = alt ? 0 : 1
    "   #{str}   ".colorize(:background => BOARD_COLORS[color])
  end
end

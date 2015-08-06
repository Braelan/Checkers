class Board
  SIZE = 8
  BOARD_COLORS = [:light_white, :default]
  attr_accessor :grid

  def initialize
    @grid = make_grid
  end


  def set
    self.place_pieces(0, :red)
    self.place_pieces(5, :blue)
  end



  def place_pieces(start, color)

    orientation = start == 0 ? :down : :up
    count = 0
    grid.each_with_index do |row, row_idx|
        row_idx = row_idx + start
      row.each_with_index do |cell, col_idx|
        if (col_idx + 2).even? && (row_idx +2).even?
          self[[row_idx, col_idx]] = Piece.new([row_idx, col_idx], self, color, orientation, start)
        elsif (col_idx+2).odd? && (row_idx).odd?
          self[[row_idx, col_idx]] = Piece.new([row_idx, col_idx], self, color, orientation, start)
        end
      end
      count = count +1
      break if count == 3
    end

  end


  def make_grid
   Array.new(SIZE){Array.new(SIZE) }
  end

  def []= (pos, piece)
    row, col = pos[0], pos[1]
    self.grid[row][col] = piece
  end

  def [] (pos)
    row, col = pos[0], pos[1]
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

  def valid_sequence

  end

  def move(start_pos, end_pos)
    piece = self[start_pos]
    if check_move(start_pos, end_pos)  || check_jump(start_pos, end_pos)
      remove_enemy(start_pos, end_pos) if check_jump(start_pos, end_pos)
    self[start_pos] = nil
    self[end_pos] = piece
    piece.pos = end_pos
  else raise "That's illegal!"
    end
  end

  def to_delta(start_pos, end_pos)
    [end_pos[0] - start_pos[0], end_pos[1] - start_pos[1]]
  end

  def jump_delta(start_pos, end_pos)
      jump = to_delta(start_pos, end_pos)
      [jump[0]/2, jump[1]/2]
  end

  def check_move(start_pos, end_pos)
    delta = to_delta(start_pos, end_pos)
    piece = self[start_pos]
   !piece.nil?  && piece.perform_slide?(delta) && piece.move_diffs.include?(delta)
  end

  def check_jump(start_pos, end_pos)
    delta = jump_delta(start_pos, end_pos)
    piece = self[start_pos]
    !piece.nil?  && piece.perform_jump?(delta) && piece.move_diffs.include?(delta)
  end

  def remove_enemy(start_pos, end_pos)
      delta = jump_delta(start_pos, end_pos)
      self[self[start_pos].transform(delta)] = nil
  end

 def do_sequence(sequence)
    start_pos = sequence.shift
    end_pos = sequence.shift
   while !end_pos.nil?
     raise "not a valid sequence" if !check_jump(start_pos, end_pos)
     move(start_pos, end_pos)
     start_pos = end_pos
     end_pos = sequence.shift
   end
   nil
 end

 # this takes an array of arrays
 def move_or_sequence(sequence)
   if sequence.length > 2
     do_sequence(sequence)
  else move(sequence[0], sequence[1])
   end
 end

 def dup
   new_board = Board.new
     pieces.each do |piece|
       piece.class.new(piece.pos, new_board, piece.color, piece.orientation)
     end
     new_board
 end

 def pieces
    grid.flatten.compact
 end

 def dup_moves(sequence)
   begin
   tester = self.dup
   tester.do_sequence(sequence)
   rescue
     false
   end
   true
 end

 def move!(sequence)
   move_list = sequence.map {|coord| coord.dup}
   check = true
   if sequence.length > 2
     check = self.dup_moves(sequence)
   end
   move_or_sequence(move_list) if check
   #self[move_list.last].promote if check
 end


 end

require_relative 'piece.rb'
require_relative 'board.rb'
 board = Board.new
  board.set
  board.render


  board.do_sequence([[2,4],[4,2],[6,4]])
   board.move([2,2],[3,1])
    board.move([3,1],[4,2])
     board.move([1,3],[2,2])
 sleep(2)
 gets

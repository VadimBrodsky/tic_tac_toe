require 'pry'

class Cell
  attr_accessor :mark, :index
  attr_reader :coordinate
end


class Board

  attr_reader :board

  def initialize
    @board = {}
    (1..9).each{|i| @board[i] = ''}
  end

  def print_board
    values = @board.values

  end

  def add_mark(mark, position)
    row = position / 3
    @board[row][]
  end
end

ttt = Board.new
p ttt

binding.pry

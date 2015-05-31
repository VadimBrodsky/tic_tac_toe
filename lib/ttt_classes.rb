require 'pry'

class Cell
  attr_accessor :mark, :index
  attr_reader :column, :row

  def initialize(index, mark = ' ')
    self.index = index
    self.mark = mark
  end

  def index=(i)
    @index = i if (1..9).include? i
    set_coordinates(index)
  end

  def mark=(m = 'X')
    @mark = m
  end

  def set_coordinates(index)
    @row = set_row(index)
    @column = set_column(index)
  end

  def to_s
    mark
  end

  def last_row?
    row == 3
  end

  def last_column?
    column == 3
  end

  private

  def set_row(i)
    return 1 if (1..3).include? i
    return 2 if (4..6).include? i
    return 3 if (7..9).include? i
  end

  def set_column(i)
    return 1 if (1..7).step(3).include? i
    return 2 if (2..8).step(3).include? i
    return 3 if (3..9).step(3).include? i
  end
end


class Board
  attr_reader :board

  def initialize(guide: false)
    @board = (1..9).map{|i| Cell.new(i)}
    @board = (1..9).map{|i| Cell.new(i, i.to_s)} if guide
  end

  def draw_board
    @board.each do |cell|
      print " #{cell} "
      print cell.last_column? ? "\n" : '|'
      puts '---+---+---' if cell.last_column? && !cell.last_row?
    end
    puts ''
  end

  def mark(position, mark = 'X')
    @board[position - 1].mark = mark
  end
end



class Game
  def initialize
    @guide = Board.new(guide: true)
    @ttt = Board.new
    welcome
    play
  end

  def welcome
    system('clear')
    puts "Welcome to Tic-Tac-Toe\n\n"
    @guide.draw_board
  end

  def play
    player_choice = ask_input
  end

  def ask_input
    input = ''
    loop do
      print 'Choose a position (1 to 9) to place X or G for guide: '
      input = gets.chomp.downcase
      break if %w(1 2 3 4 5 6 7 8 9 g).include? input
    end
    input
  end
end


Game.new
binding.pry

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

  def is_blank?
    mark == ' '
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

  def initialize
    @board = (1..9).map{|i| Cell.new(i)}
  end

  def draw_board
    @board.each do |cell|
      print_row(cell)
    end
    puts ''
  end

  def draw_guide_board
    @board.each do |cell|
      guide_cell = cell.dup
      guide_cell.mark = cell.is_blank? ? cell.index : cell.mark
      print_row(guide_cell)
    end
  end

  def print_row(cell)
    print " #{cell.mark} "
    print cell.last_column? ? "\n" : '|'
    puts '---+---+---' if cell.last_column? && !cell.last_row?
  end

  def mark(position, mark = 'X')
    @board[position - 1].mark = mark if @board[position - 1].is_blank?
  end

  def blank_spaces
    spaces = []
    board.each do |cell|
      spaces << cell.index if cell.is_blank?
    end
    spaces
  end

  def row(r = 1)
    @board.find_all {|cell| cell if cell.row == r}
  end

  def column(c = 1)
    @board.find_all {|cell| cell if cell.column == c}
  end

  def diagonal(d = 1)
    if d == 1
      @board.find_all{|cell| cell if cell.row == cell.column}
    elsif d == 2
      @board.find_all{|cell| cell if [3, 5, 7].include? cell.index }
    end
  end
end



class Game
  def initialize
    @ttt = Board.new
    @winner = nil
    welcome
    play
  end

  def welcome
    system('clear')
    puts "Welcome to Tic-Tac-Toe\n\n"
    @ttt.draw_guide_board
    puts ''
  end

  def play
    loop do
      player_position = ask_input
      if player_position == 'g'
        draw_guide_board
        next
      end

      if @ttt.blank_spaces.include?(player_position.to_i)
        player_make_mark(player_position.to_i)
        computer_make_mark
      end

      redraw_borad

      binding.pry

      break if game_over?
    end
  end

  def redraw_borad
    # system('clear')
    puts "\n\n"
    @ttt.draw_board
  end

  def draw_guide_board
    system('clear')
    puts "\n\n"
    @ttt.draw_guide_board
    puts ''
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

  def player_make_mark(position)
    @ttt.mark(position, 'X')
  end

  def computer_make_mark
    computer_position =  @ttt.blank_spaces.sample
    @ttt.mark(computer_position, 'O')
  end

  def winning_row?(r = 1)
    win_mark = @ttt.row(r).collect{|c| c.mark}.uniq
    win_mark.length == 1 && win_mark.first != ' '
  end

  def winning_column?(c = 1)
    win_mark = @ttt.column(c).collect{|c| c.mark}.uniq
    win_mark.length == 1 && win_mark.first != ' '
  end

  def winning_diagonal?(d = 1)
    if d < 3
      win_mark = @ttt.diagonal(d).collect{|c| c.mark}.uniq
      win_mark.length == 1 && win_mark.first != ' '
    else
      []
    end
  end

  def game_over?
    (1..3).each do |i|
      @winner = @ttt.row(i).first.mark if winning_row?(i)
      @winner = @ttt.row(i).first.mark if winning_column?(i)
      @winner = @ttt.row(i).first.mark if winning_diagonal?(i)
    end
    !@winner.nil?
  end
end


Game.new
# binding.pry

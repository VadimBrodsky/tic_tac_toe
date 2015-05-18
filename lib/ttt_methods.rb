# Tic Tac Toe Methods
require 'pry'

BOARD_POSITIONS = (1..9).to_a

BOARD_WIDTH = 3
BOARD_HEIGHT  = 3

VERTICAL_LINES =   '     |     |     '
HORIZONTAL_LINES = '-----+-----+-----'
PLAYER_PIECE   = 'X'
COMPUTER_PIECE = 'O'

def initialize_board(numbers = false)
  board = {}
  if numbers
    BOARD_POSITIONS.each { |i| board[i] = i }
  else
    BOARD_POSITIONS.each { |i| board[i] = false }
  end
  board
end

def draw_line(val1, val2, val3, last = false)
  puts VERTICAL_LINES
  puts "  #{val1 || ' '}  |  #{val2 || ' '}  |  #{val3 || ' '}"
  puts VERTICAL_LINES
  puts last ? '' : HORIZONTAL_LINES
end

def draw_board(b)
  draw_line(b[1], b[2], b[3])
  draw_line(b[4], b[5], b[6])
  draw_line(b[7], b[8], b[9], true)
end

def draw_guide_board(b)
  guide_board = b.dup

  system('clear')
  puts "Guide of Positions \n\n\n"

  guide_board.each do |key, value|
    guide_board[key] = key if value == false
  end

  draw_board(guide_board)
end

def available_positions(b)
  board = b.dup
  board.delete_if do |key|
    b[key]
  end
end

def computer_choose_position(b)
  positions = available_positions(b)

  # binding.pry

  # If there are no O on the board go randomly
  if !b.value?(COMPUTER_PIECE)
    positions.keys.sample
  else
    positions.keys.sample
  end
end

def position_not_taken?(board, position)
  positions = available_positions(board)
  positions.key?(position)
end

# Returns an array of values for the specified row
def board_row_values(board, row_number)
  start_value = row_number == 1 ? 0 : (row_number * BOARD_WIDTH) - BOARD_WIDTH
  board.values.slice(start_value, BOARD_WIDTH)
end

# Returns an array of values for the specified column
def board_column_values(board, column_number)
  column_values = []

  BOARD_HEIGHT.times do |i|
    column_values << board.values[column_number - 1 + BOARD_WIDTH * i]
  end
  column_values
end

# Returns an array of values for the specified diagonal, left by default
def board_diagonal_values(board, left_diagonal = true)
  values = []
  start_at = left_diagonal ? 1 : 3
  BOARD_HEIGHT.times do
    values << board[start_at]
    start_at += BOARD_WIDTH
    start_at = left_diagonal ? start_at + 1 : start_at - 1
  end
  values
end

def one_unique_value?(array_of_values)
  array_of_values.count == 1 && array_of_values[0] && array_of_values[0] != ' '
end

# Accepts an array of values, evaluates if victory condition met on row
def victory_row?(row_values)
  unique_values = row_values.uniq
  one_unique_value?(unique_values)
end

# Accepts an array of values, evaluates if victory condition met on column
def victory_column?(column_values)
  unique_values = column_values.uniq
  one_unique_value?(unique_values)
end

def victory_diagonal?(diagonal_values)
  unique_values = diagonal_values.uniq
  one_unique_value?(unique_values)
end

# Returns the winning row number otherwise false
def horizontal_victory(b)
  win = false

  (1..BOARD_HEIGHT).each do |i|
    row_values = board_row_values(b, i)
    win = i if victory_row?(row_values)
  end

  win
end

# Returns the winning column number otherwise false
def vertical_victory(b)
  win = false

  (1..BOARD_WIDTH).each do |i|
    column_values = board_column_values(b, i)
    win = i if victory_column?(column_values)
  end

  win
end

# Returns the winning diagonal number otherwise false
def diagonal_victory(b)
  if victory_diagonal?(board_diagonal_values(b, true))
    1
  elsif victory_diagonal?(board_diagonal_values(b, false))
    2
  else
    false
  end
end

def end_game(board)
  if horizontal_victory(board)
    true
  elsif vertical_victory(board)
    true
  elsif diagonal_victory(board)
    true
  elsif available_positions(board).empty?
    true
  else
    false
  end
end

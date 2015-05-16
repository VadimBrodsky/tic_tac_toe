# Tic Tac Toe Methods

BOARD_POSITIONS = (1..9).to_a
VERTICAL_LINES =   "     |     |     "
HORIZONTAL_LINES = "-----+-----+-----"
PLAYER_PIECE   = 'X'
COMPUTER_PIECE = 'O'

def initialize_board(numbers=false)
  board = {}
  if numbers
    BOARD_POSITIONS.each { |i| board[i] = i }
  else
    BOARD_POSITIONS.each { |i| board[i] = false }
  end
  board
end


def draw_board(b)
  puts VERTICAL_LINES
  puts "  #{b[1] || ' '}  |  #{b[2] || ' '}  |  #{b[3] || ' '}"
  puts VERTICAL_LINES
  puts HORIZONTAL_LINES
  puts VERTICAL_LINES
  puts "  #{b[4] || ' '}  |  #{b[5] || ' '}  |  #{b[6] || ' '}"
  puts VERTICAL_LINES
  puts HORIZONTAL_LINES
  puts VERTICAL_LINES
  puts "  #{b[7] || ' '}  |  #{b[8] || ' '}  |  #{b[9] || ' '}"
  puts VERTICAL_LINES
  puts ""
end


def draw_guide_board(b)
  guide_board = b.dup

  system("clear")
  puts "Guide of Positions \n\n\n"

  guide_board.each do |key, value|
    if value == false
      guide_board[key] = key
    end
  end

  draw_board(guide_board)
end


def available_positions(b)
  board = b.dup
  board.delete_if do |key, value|
    b[key]
  end
end


def computer_choose_position(b)
  positions = available_positions(b)

  # binding.pry

  # If there are no O on the board go randomly
  if !b.has_value?(COMPUTER_PIECE)
    positions.keys.sample
  else
    positions.keys.sample
  end


end


def position_not_taken?(board, position)
  positions = available_positions(board)
  positions.has_key?(position)
end


def horizontal_victory(b)
  win = false
  [1, 4, 7].each do |i|
    if b[i] != ' ' &&  ( b[i] == b[i + 1] ) && ( b[i + 1] == b [i + 2] )
      win = b[i]
      break
    end
  end
  win
end


def vertical_victory(b)
  win = false
  (1..3).each do |i|
    if ( b[i] == b[i + 3] ) && ( b[i + 3] == b[i + 6])
      win = b[i]
      break
    end
  end
  win
end


def diagonal_victory(b)
  if ( (b[1] == b[1 + 4]) && (b[1 + 4] == b[1 + 8]) ) ||
     ( (b[3] == b[3 + 2]) && (b[3 + 2] == b[3 + 4]) )
    b[5]
  else
    false
  end
end


def end_game(board)
  if horizontal_victory(board)
    horizontal_victory(board)
  elsif vertical_victory(board)
    vertical_victory(board)
  elsif diagonal_victory(board)
    diagonal_victory(board)
  elsif available_positions(board).empty?
    true
  end
end

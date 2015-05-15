# - Initialize the board
# - Draw TTT board
# - Player 1 chooses a position
# - Computer chooses a position
# - If a line of 3 is detected or no more room on the board end game


# Better AI:
# - Get the hash of the board
# - Evaluate current positions of O
# - Evaluate open areas on the board
# - Rank the open areas on the board by
#    - Checking Win rules
#    - Counting giving more weight to the position that appears in most rules
# - Pick the highest ranking position


require 'pry'

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

  binding.pry

  # If there are no O on the board go randomly
  if !b.has_value?(COMPUTER_PIECE)
    positions.keys.sample
  # else

  end


end


def position_not_taken?(board, position)
  positions = available_positions(board)
  positions.has_key?(position)
end


def horizontal_victory(b)
  win = false
  [1, 4, 7].each do |i|
    if ( b[i] == b[i + 1] ) && ( b[i + 1] == b [i + 2] )
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


system("clear")
puts "Welcome to Tic-Tac-Toe! \n\n\n"


draw_board(initialize_board(true))
game_board = initialize_board


# Main Game Loop
begin

  # Get user position
  begin
    print "Choose a position (1 to 9) to place 'X' or G for guide: "
    player_position = gets.chomp

    if player_position.downcase == 'g'
      draw_guide_board(game_board)
    end
    player_position = player_position.to_i

  end until BOARD_POSITIONS.include?(player_position) &&
                            position_not_taken?(game_board, player_position)

  game_board[player_position] = PLAYER_PIECE

  computer_position = computer_choose_position(game_board)
  game_board[computer_position] = COMPUTER_PIECE

  system("clear")
  puts "You placed X in position #{player_position}"
  puts "Computer placed O in position #{computer_position}"

  puts "\n"

  # Draw new board
  draw_board(game_board)

end until end_game(game_board)


puts "Game Over!"

case end_game(game_board)
when PLAYER_PIECE
  puts "You Won!"
when COMPUTER_PIECE
  puts "Computer Won!"
else
  "It's a tie!"
end

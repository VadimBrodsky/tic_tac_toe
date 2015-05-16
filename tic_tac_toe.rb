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
require './lib/ttt_methods'


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

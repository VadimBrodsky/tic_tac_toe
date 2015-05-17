require 'minitest/autorun'
require 'ttt_methods'

class GameTest < Minitest::Test
  # def setup
  #   @board = {1=>'',2=>'',3=>'',4=>'',5=>'',6=>'',7=>'',8=>'',9=>''}
  # end

  def test_horizontal_victory
    board_1 = {1=>'X',2=>'X',3=>'X',4=>'',5=>' ',6=>' ',7=>' ',8=>' ',9=>' '}
    assert_equal horizontal_victory(board_1), 1

    board_2 = {1=>' ',2=>' ',3=>' ',4=>'X',5=>'X',6=>'X',7=>' ',8=>' ',9=>' '}
    assert_equal horizontal_victory(board_2), 2

    board_3 = {1=>' ',2=>' ',3=>' ',4=>' ',5=>' ',6=>' ',7=>'X',8=>'X',9=>'X'}
    assert_equal horizontal_victory(board_3), 3

    false_board = {1=>'O',2=>'O',3=>'X',4=>'X',5=>'O',6=>'O',7=>' ',8=>'X',9=>'X'}
    assert_equal horizontal_victory(false_board), false
  end


  def test_vertical_victory
    board_1 = {1=>'X',2=>' ',3=>' ',4=>'X',5=>' ',6=>' ',7=>'X',8=>' ',9=>' '}
    assert_equal vertical_victory(board_1), 'X'

    board_2 = {1=>' ',2=>'X',3=>' ',4=>' ',5=>'X',6=>' ',7=>' ',8=>'X',9=>' '}
    assert_equal vertical_victory(board_2), 'X'

    board_3 = {1=>' ',2=>' ',3=>'X',4=>' ',5=>' ',6=>'X',7=>' ',8=>' ',9=>'X'}
    assert_equal vertical_victory(board_3), 'X'

    false_board = {1=>' ',2=>' ',3=>' ',4=>' ',5=>' ',6=>' ',7=>' ',8=>'X',9=>'X'}
    assert_equal vertical_victory(false_board), false
  end

end

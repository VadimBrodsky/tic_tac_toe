require 'minitest/autorun'
require 'ttt_methods'

class GameTest < Minitest::Test
  # def setup
  #   @board = {1=>'',2=>'',3=>'',4=>'',5=>'',6=>'',7=>'',8=>'',9=>''}
  # end

  def test_horizontal_victory
    board_1 = {1=>'X',2=>'X',3=>'X',4=>'',5=>' ',6=>' ',7=>' ',8=>' ',9=>' '}
    assert_equal horizontal_victory(board_1), 'X'

    board_2 = {1=>' ',2=>' ',3=>' ',4=>'X',5=>'X',6=>'X',7=>' ',8=>' ',9=>' '}
    assert_equal horizontal_victory(board_2), 'X'

    board_3 = {1=>' ',2=>' ',3=>' ',4=>' ',5=>' ',6=>' ',7=>'X',8=>'X',9=>'X'}
    assert_equal horizontal_victory(board_3), 'X'
  end

end

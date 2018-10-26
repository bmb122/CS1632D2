require 'minitest/autorun'
require_relative 'game.rb'

class GameTest < Minitest::Test

  def test_seed_equivalence
    g0 = Game.new 20, 1
		g1 = Game.new 20, 1
		assert_equal g0.see_seed, g1.see_seed
	end



end
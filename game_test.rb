require 'minitest/autorun'
require_relative 'game.rb'

class GameTest < Minitest::Test
	def setup
		@game = Game.new 1, 1
	end
  def test_seed_equivalence
    game1 = Game.new 1, 1
		assert_equal @game.seed, game1.seed
	end
	
	#Test that the map correctly connects the edges to vertices
	def test_create_map
		g = Graph.new []
		@game.create_map(g)
		assert g.vertices[0].neighbors[1]
	end
	
	def test_keep_searching_after_third_location
		vert = Minitest::Mock::new "vert 1"
		vert.expect :gold, 1
		vert.expect :silver, 1
		vert.expect :name, 'vert'
		@game.keep_searching(vert, 4)
	end
	
	def test_search_iterations
		@game.search(5)
	end
	
	def test_end_shift_earnings
		@game.end_shift(1, 1, 1)
		assert_equal 21.98, earnings
	end

end
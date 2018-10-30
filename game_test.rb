require 'minitest/autorun'
require_relative 'game.rb'

class GameTest < Minitest::Test
	
  # This test ensures that the seed generated in the initialization
	# of a Game object will always be equivalent through all runs of the 
	# program, given that the user sends the same parameter for it. This
	# seed is created through calling a randomizer with the *seed* parameter
	# as an argument
	def test_seed_equivalence
		game = Game.new 1, 1
    game1 = Game.new 1, 1
		assert_equal game.seed, game1.seed
	end
	
	# This test checks to make sure play_game iterates the correct amount
	# of times through searching for metals. It checks to make sure we only iterate
	# for the number of prospectors passed into the object. We stub the other two methods
	# as we are only worried about if play_game works correctly.
	def test_play_game_break
		game = Game.new 1, 10
		game.stub :search, true do
			game.stub :end_shift, true do
				game.play_game
				assert_equal game.iterations, game.prospectors
			end
		end
	end
	
	# Test that the map correctly connects the edges to vertices.
	# It checks that the prospector is able to travel to and from
	# the correct mining facilities according to the map given.
	def test_create_map
		game = Game.new 1, 1
		g = Graph.new []
		game.create_map(g)
		assert g.vertices[0].neighbors[1]
		assert g.vertices[0].neighbors[2]
		assert g.vertices[1].neighbors[4]
		assert g.vertices[2].neighbors[3]
		assert g.vertices[2].neighbors[4]
		assert g.vertices[4].neighbors[5]
		assert g.vertices[4].neighbors[6]
		assert g.vertices[5].neighbors[6]
	end
	
	
	# This test ensures that if the prospector finds 0 ounces
	# of either silver or gold while searching,
	# he/she will leave. With the vertex holding 0 for the values of
	# silver and gold, the prospector will never find any. We check to
	# make sure he/she leaves after the first day of not finding anything
	def test_keep_searching_find_no_metals
		game = Game.new 1, 1
		vert = Minitest::Mock::new "vert 1"
		vert.expect :gold, 0
		vert.expect :silver, 0
		vert.expect :name, 'Gold Saucer'
		game.keep_searching(vert, 1)
		assert_equal 1, game.days
	end
	
	# This test ensures that if the prospector finds one ounce
	# of either silver or gold in his/her first three days of searching,
	# he/she will stay until no metals are found. With the specific seed generation of 1, 
	# the prospector will find one ounce of silver and gold in the first day,
	# then find nothing the second. We check to make sure he/she stays for the 
	# second day at Gold Saucer
	# EDGE CASE
	def test_keep_searching_third_location
		game = Game.new 1, 1
		vert = Minitest::Mock::new "vert 1"
		vert.expect :gold, 1
		vert.expect :gold, 0
		vert.expect :silver, 1
		vert.expect :silver, 0
		vert.expect :name, 'Gold Saucer'
		vert.expect :name, 'Gold Saucer'
		game.keep_searching(vert, 3)
		refute_equal 1, game.days
	end
	
	# This test ensures that if the prospector finds one ounce or less
	# of either silver or gold in his/her last two days of searching,
	# he/she will leave. With the specific seed generation of 1, the prospector will
	# always only find one ounce of silver. We check to make sure he/she
	# leaves after only one day of searching.
	# EDGE CASE
	def test_keep_searching_after_third_location
		game = Game.new 1, 1
		vert = Minitest::Mock::new "vert 1"
		vert.expect :gold, 1
		vert.expect :silver, 1
		vert.expect :name, 'Gold Saucer'
		game.keep_searching(vert, 4)
		assert_equal 1, game.days
	end
	
	
	# This test ensures that the prospector searches 5 locations
	# exactly. Once the counter exceeds this limit of 5, the search function
	# should caese entirely.
	# EDGE CASE
	def test_search_five_iterations
		game = Game.new 1, 1
		game.stub :keep_searching, true do
			game.search(1)
			refute_equal 5, game.loc
		end	
	end
	
	# This test ensures that the prospector only searches at 5 locations
	# exactly. Once the counter exceeds this limit of 5 (i.e. 6), the search function
	# should caese entirely, therefore causing the loc variable to be six
	# when search halts.
	# EDGE CASE
	def test_search_six_iterations
		game = Game.new 1, 1
		game.stub :keep_searching, true do
			game.search(1)
			assert_equal 6, game.loc
		end	
	end
	
	# This test checks to make sure the correct earnings are recorded
	# for each prospector according to the given price per ounce of
	# silver and gold.
	def test_end_shift_earnings
		game = Game.new 1, 1
		game.metals = [1, 1]
		game.end_shift(1.31, 20.67, 1)
		assert_equal 21.98, game.earnings
	end

end
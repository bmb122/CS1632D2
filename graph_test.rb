require 'minitest/autorun'
require_relative 'graph.rb'

class GraphTest < Minitest::Test

	def test_vertex_intialization
		v = Vertex.new 'vert', 1, 2
		assert_equal 'vert', v.name
		assert_equal 1, v.silver
		assert_equal 2, v.gold
	end
	
	#stub method
	def test_graph_initialization
		mock_vert = Minitest::Mock.new("vert")
		def mock_vert.name; 'vert'; end
		g = Graph.new mock_vert
		assert_equal mock_vert, g.vertices
	end
	
	def test_add_neighbor
		v1 = Vertex.new 'v1', 1, 2
		v2 = Vertex.new 'v2', 2, 2
		g = Graph.new [v1, v2]
		g.add_neighbor('v1', 'v2')
		assert_equal true, v1.neighbors[1]
	end
end
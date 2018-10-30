# Class to create the vertices(cites) graph of cities
class Vertex
  attr_accessor :name, :neighbors, :silver, :gold

  def initialize(name, silver, gold)
    @name = name
    @neighbors = []
    @silver = silver
    @gold = gold
  end
end

# Class to create the map of the cities, and their neighbors
class Graph
  attr_accessor :vertices

  def initialize(verts)
    @vertices = verts
  end

  def add_vertex(name, silver, gold)
    @vertices << Vertex.new(name, silver, gold)
  end

  def add_neighbor(start_name, end_name)
    from = vertices.index { |v| v.name == start_name }
    to   = vertices.index { |v| v.name == end_name }
    vertices[from].neighbors[to] = true
    vertices[to].neighbors[from] = true
  end
end

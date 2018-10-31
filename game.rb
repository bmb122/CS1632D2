require_relative 'graph.rb'
# Documentation for class
class Game
  attr_accessor :seed, :prospectors, :metals, :earnings, :days, :loc, :iterations, :goz, :soz

  def initialize(seed, num_prospectors)
    srand seed
    @seed = rand(seed)
    @prospectors = num_prospectors
    @g = Graph.new []
    create_map(@g)
    @days = 0
    @metals = [0, 0]
    @r = Random.new(@seed)
    @earnings = 0
  end

  def play_game
    @iterations = 0
    loop do
      @iterations += 1
      search(@iterations)
      end_shift(1.31, 20.67, @iterations)
      break if @iterations == @prospectors
    end
  end

  def create_map(graph)
    graph.add_vertex 'Sutter Creek', 0, 2
    graph.add_vertex 'Coloma', 0, 3
    graph.add_vertex 'Angels Camp', 0, 4
    graph.add_vertex 'Nevada City', 0, 5
    graph.add_vertex 'Virginia City', 3, 3
    graph.add_vertex 'Midas', 5, 0
    graph.add_vertex 'El Dorado Canyon', 10, 0
    graph.add_neighbor 'Sutter Creek', 'Coloma'
    graph.add_neighbor 'Sutter Creek', 'Angels Camp'
    graph.add_neighbor 'Coloma', 'Virginia City'
    graph.add_neighbor 'Angels Camp', 'Nevada City'
    graph.add_neighbor 'Angels Camp', 'Virginia City'
    graph.add_neighbor 'Virginia City', 'Midas'
    graph.add_neighbor 'Virginia City', 'El Dorado Canyon'
    graph.add_neighbor 'Midas', 'El Dorado Canyon'
  end

  def search(pros)
    @loc = 0
    @metals = [0, 0]
    @days = 0
    pre_vert = ''
    vert = @g.vertices[0]
    puts "\n" + 'Prospector #' + pros.to_s + ' starting in ' + vert.name + '.'
    loop do
      @loc += 1
      break if @loc > 5

      if @loc != 1
        @goz = 'ounce' if @metals[1] == 1
        @goz = 'ounces' if @metals[1] != 1
        @soz = 'ounce' if @metals[0] == 1
        @soz = 'ounces' if @metals[0] != 1
        puts 'Heading from ' + pre_vert.name + ' to ' + vert.name + ', holding ' + @metals[1].to_s + ' ' \
				'' + @goz + ' of gold and ' + @metals[0].to_s + ' ' + @soz + ' of silver.'
      end
      keep_searching(vert, loc)
      loop do
        next_site = @r.rand(8)
        if vert.neighbors[next_site] == true
          pre_vert = vert
          vert = @g.vertices[next_site]
          break
        end
      end
    end
  end

  def keep_searching(vert, loc)
    @goz = 'ounces'
    @soz = 'ounces'
    ks = true
    g = 0
    s = 0
    loop do
      return unless ks

      @days += 1 if ks

      g = @r.rand(vert.gold + 1)
      s = @r.rand(vert.silver + 1)
      @metals[0] += s
      @metals[1] += g
      ks = false if loc > 3 && g <= 1 && s <= 1
      if g.zero? && s.zero?
        puts "\t" + 'No precious metals were found'
        ks = false
      elsif g > 0 && s.zero?
        @goz = 'ounce' if g == 1
        @goz = 'ounces' if g != 1
        puts "\t" + 'Found ' + g.to_s + ' ' + @goz + ' of gold in ' + vert.name + '.'
      elsif s > 0 && g.zero?
        @soz = 'ounce' if s == 1
        @soz = 'ounces' if s != 1
        puts "\t" + 'Found ' + s.to_s + ' ' + @soz + ' of silver in ' + vert.name + '.'
      else
        @goz = 'ounce' if g == 1
        @goz = 'ounces' if g != 1
        @soz = 'ounce' if s == 1
        @soz = 'ounces' if s != 1
        puts "\t" + 'Found ' + g.to_s + ' ' + @goz + ' of gold and ' + s.to_s + ' ' \
				'' + @soz + ' of silver in ' + vert.name + '.'
      end
    end
  end

  def end_shift(silverp, goldp, prospector)
    @goz = 'ounce' if @metals[1] == 1
    @goz = 'ounces' if @metals[1] != 1
    @soz = 'ounce' if @metals[0] == 1
    @soz = 'ounces' if @metals[0] != 1
    @earnings = '%.2f' % (@metals[0] * silverp + @metals[1] * goldp)
    puts 'After ' + @days.to_s + ' days, Prospector #' + prospector.to_s + ' returned to San Francisco with: '
    puts "\t" + @metals[1].to_s + ' ' + @goz + ' of gold.'
    puts "\t" + @metals[0].to_s + ' ' + @soz + ' of silver.'
    puts "\t" + 'Heading home with $' + @earnings.to_s + '.'
  end
end

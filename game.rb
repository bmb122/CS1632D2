class Game

def initialize(seed, num_prospectors)
    srand seed            # seed
	@seed = rand(seed)
	puts @seed
    @prospectors = num_prospectors
  end
  
end
require_relative 'game.rb'
require_relative 'args.rb'

# EXECUTION STARTS HERE

valid_args = check_args ARGV
if valid_args
  a0 = Integer(ARGV[0])
  a1 = Integer(ARGV[1])
  g = Game.new a0, a1
  g.play_game
	
else
  show_usage
  exit 1
end

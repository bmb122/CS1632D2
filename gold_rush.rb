require_relative 'game.rb'
require_relative 'args.rb'

# EXECUTION STARTS HERE

valid_args = check_args ARGV
if valid_args
  g = Game.new a0, a1
else
  show_usage
  exit 1
end

require_relative 'game.rb'
def show_usage_and_exit
  puts 'Usage:'
  puts 'ruby gold_rush.rb *seed* *num_prospectors*'
  puts '*seed* should be an integer '
  puts '*num_prospectors* should be a non-negative integer'
  exit 1
end

def check_args(args)
  args.count == 2 && a1 > 0
rescue StandardError
  false
end
# EXECUTION STARTS HERE
a0 = Integer(ARGV[0])
a1 = Integer(ARGV[1])
valid_args = check_args ARGV a1
if valid_args
  g = Game.new a0, a1
else
  show_usage_and_exit
end

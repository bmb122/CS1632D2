#require_relative 'game'

# EXECUTION STARTS HERE

raise "\nUsage:
ruby gold_rush.rb *seed* *num_prospectors*
*seed* should be an integer
*num_prospectors* should be a non-negative integer" if ARGV.count != 2 or ARGV[0].is_a?(Integer) == false or ARGV[1].is_a?(Integer) == false #or (ARGV[1].is_a?(Integer) == true and ARGV[1] <= 0)
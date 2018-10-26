def show_usage
  puts 'Usage:'
  puts 'ruby gold_rush.rb *seed* *num_prospectors*'
  puts '*seed* should be an integer'
  puts '*num_prospectors* should be a non-negative integer'
end

def check_args(args)
  a0 = Integer(args[0])
  a1 = Integer(args[1])
  args.count == 2 && a1 >= 0
rescue StandardError
  false
end
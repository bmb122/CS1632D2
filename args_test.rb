require 'minitest/autorun'
require_relative 'args'

class ArgsTest < Minitest::Test
  def test_usage_output
    expected_output = "Usage:\n" \
    "ruby gold_rush.rb *seed* *num_prospectors*\n" \
	  "*seed* should be an integer\n" \
	  "*num_prospectors* should be a non-negative integer\n"
    assert_output expected_output do
			show_usage
	  end
  end
  
  def test_nil_args
    refute check_args(nil)
  end
  
  def test_two_proper_args
     assert check_args([1, 1])
  end
	
  def test_neg_prospectors
		refute check_args([1, -1])
	end
end

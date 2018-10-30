require 'minitest/autorun'
require_relative 'args'

class ArgsTest < Minitest::Test

	# This test ensures that the correct error message displays to the
	# user if they input the incorrect parameters into the program.
  def test_usage_output
    expected_output = "Usage:\n" \
    "ruby gold_rush.rb *seed* *num_prospectors*\n" \
	  "*seed* should be an integer\n" \
	  "*num_prospectors* should be a non-negative integer\n"
    assert_output expected_output do
			show_usage
	  end
  end
  
	# This test ensures that check_args will fail, given that the user passes
	# in no parameters into the program.
  def test_nil_args
    refute check_args(nil)
  end
  
	# This test checks to make sure that check_args passes, given that the user
	# sends exactly two parameters, with the first being an integer, and the second a
	# non-negative integer.
  def test_two_proper_args
     assert check_args([1, 1])
  end
	
	# This test checks to make sure that check_args will fail, given that the
	# user sends a negative integer into the *prospectors* parameter
  def test_neg_prospectors
		refute check_args([1, -1])
	end
	
	# This test checks to make sure that check_args still passes, given that 
	# the user sends zero into the *prospectors* parameter
	# EDGE CASE
	def test_zero_prospectors
		assert check_args([1, 0])
	end
end

#!/usr/bin/env ruby

gem 'minitest'
require "minitest/autorun"


class ClosestPair
  def brute_force_closest_pair l
  end

  def divide_and_conqure_closest_pair l
  end

  private
end



class ClosestPairTest < Minitest::Test
  def setup
    @closest_pair = ClosestPair.new
  end

  def test_brute_force_closest_pair
  end

  def test_divide_and_conqure_closest_pair
    skip
  end
end

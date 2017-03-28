#!/usr/bin/env ruby

gem 'minitest'
require "minitest/autorun"


class Inversions
  def brute_force_inversions l
    do_brute_force_inversions l.drop(1), l.first, 0
  end

  private

  def do_brute_force_inversions l, first, count
    if l.empty?
      count
    else
      do_brute_force_inversions(l.drop(1), l.first, get_inversion_for_pair(l, first, count))
    end
  end

  def get_inversion_for_pair l, first, count
    l.inject(count) do | c, n |
      if first > n
        c + 1
      else
        c
      end
    end
  end
end



class InversionsTest < Minitest::Test
  def setup
    @inversions = Inversions.new
    @none = [1, 2, 3, 4, 5, 6]
    @max = [6, 5, 4, 3, 2, 1]
    @some = [1, 3, 5, 2, 4, 6]
  end

  def test_brute_force_sort
    assert_equal(0, @inversions.brute_force_inversions(@none))
    assert_equal(15, @inversions.brute_force_inversions(@max))
    assert_equal(3, @inversions.brute_force_inversions(@some))
  end
end

#!/usr/bin/env ruby

gem 'minitest'
require "minitest/autorun"


class Sort

  def brute_force_sort l
    l
  end

  def merge_sort l
    l
  end

  private
end

class SortTest < Minitest::Test
  def setup
    @sort = Sort.new
    @sorted = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    @already_sorted = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    @backwards = [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
    @random = [6, 1, 10, 9, 5, 8, 7, 4, 2, 3]
  end

  def test_brute_force_sort
    assert_equal @sorted, @sort.brute_force_sort(@already_sorted)
    assert_equal @sorted, @sort.brute_force_sort(@backwards)
    assert_equal @sorted, @sort.brute_force_sort(@random)
  end

  def test_merge_sort
    assert_equal @sorted, @sort.merge_sort(@already_sorted)
    assert_equal @sorted, @sort.merge_sort(@backwards)
    assert_equal @sorted, @sort.merge_sort(@random)
  end
end
